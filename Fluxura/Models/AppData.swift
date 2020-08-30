//
//  AppData.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/18/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import MathParser

class AppData: ObservableObject {
    public static let shared = AppData()
    
    let coefficientCount: [[Int]] = [
        [1, 2, 3, 4],
        [2, 5, 9, 14],
        [3, 9, 19, 34]
    ]
    
    // Input Values
    @Published var inputs = [[
        Input(type: 0, index: 0, value: "", cursorLocation: 0),
        Input(type: 0, index: 1, value: "", cursorLocation: 0),
        Input(type: 0, index: 2, value: "", cursorLocation: 0)
    ], [], []]
    
    // Preset Loading
    @Published var loadedPreset: Preset? = nil { didSet { refreshEntries() } }
    @Published var selectedField = "All"
    @Published var presets = Presets().presets
    
    @Published var answer = [String]()
    @Published var isInvalid: Bool = false
    @Published var invalidCount: Int = 0
    @Published var isTimeSpanInvalid: Bool = false
    @Published var isTimeIntervalInvalid: Bool = false
    
    // Data Entry
    private var inputCount1 = 1
    private var inputCount2 = 1
    @Published var activeInput = [0, 0] {
        didSet {
            if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }
            
            if UserDefaults.standard.bool(forKey: "auto_open") {
                keyboardShown = true
            }
        }
    }
    
    // DE Settings
    @Published var order = 1 { didSet { refreshEntries() } }
    @Published var vars = 1 { didSet { refreshEntries() } }
    @Published var type = 1 { didSet { refreshEntries() } }
    @Published var isLinear = true { didSet { refreshEntries() } }
    
    // Views
    @Published var keyboardShown = UserDefaults.standard.bool(forKey: "edit_on_open")
    @Published var oldState = UserDefaults.standard.bool(forKey: "edit_on_open")
    @Published var keyboardView: Int = 1
    @Published var reduceColors = UserDefaults.standard.bool(forKey: "reduce_colors")
    @Published var appTint = UserDefaults.standard.string(forKey: "app_tint")
    @Published var onboarding: Bool
    
    // Misc. Settings
    var angleType: Int {
        get { UserDefaults.standard.integer(forKey: "angle_type") }
        set { UserDefaults.standard.set(newValue, forKey: "angle_type") }
    }
    var useSigFigs: Bool {
        get { UserDefaults.standard.bool(forKey: "precision_type") }
        set { UserDefaults.standard.set(newValue, forKey: "precision_type") }
    }
    var precision: Int {
        get { UserDefaults.standard.integer(forKey: "precision") }
        set { UserDefaults.standard.set(newValue, forKey: "precision") }
    }
    var showMenu: Bool {
        get { UserDefaults.standard.bool(forKey: "show_menu") }
        set { UserDefaults.standard.set(newValue, forKey: "show_menu") }
    }
    
    @Published var presetsShown = false {
        didSet {
            if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }
            
            if presetsShown {
                self.oldState = self.keyboardShown
                self.keyboardShown = false
            } else {
                self.keyboardShown = oldState
            }
        }
    }
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            onboarding = true
        } else {
            onboarding = false
        }
        refreshEntries()
    }
    
    func refresh() {
        reduceColors = UserDefaults.standard.bool(forKey: "reduce_colors")
        appTint = UserDefaults.standard.string(forKey: "app_tint")
        
        UISwitch.appearance().onTintColor = UIColor(named: "\(appTint ?? "indigo")")
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        appearance.largeTitleTextAttributes = [.foregroundColor: reduceColors ? UIColor.systemGray : UIColor(named: appTint ?? "indigo") ?? UIColor.systemIndigo]

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func refreshEntries() {
        
        if loadedPreset != nil {
            inputCount2 = loadedPreset?.initial.count ?? 1 // Initial Conditions
            inputCount1 = loadedPreset?.parameters.count ?? 1 // Parameters
            
            inputs[1].removeAll()
            inputs[2].removeAll()
        } else {
            if type == 1 {
                inputCount2 = order
                inputCount1 = order+1
            } else {
                inputCount2 = coefficientCount[vars-1][order-1]
                inputCount1 = inputCount2 + 1
            }
        }

        while inputCount1 < inputs[1].count {
            inputs[1].removeLast()
        }
        
        while inputCount2 < inputs[2].count {
            inputs[2].removeLast()
        }
        
        while inputCount1 > inputs[1].count {
            inputs[1].append(Input(type: 1, index: inputs[1].count, value: "", cursorLocation: 0))
        }
                
        while inputCount2 > inputs[2].count {
            inputs[2].append(Input(type: 2, index: inputs[2].count, value: "", cursorLocation: 0))
        }
    }
    
    func editFormula(text: String) {
        self.inputs[activeInput[0]][activeInput[1]].value.insert(
            contentsOf: text,
            at: self.inputs[activeInput[0]][activeInput[1]].value.index(
                self.inputs[activeInput[0]][activeInput[1]].value.startIndex,
                offsetBy: self.inputs[activeInput[0]][activeInput[1]].cursorLocation
        ))
        self.inputs[activeInput[0]][activeInput[1]].cursorLocation += text.count
    }
    
    func calculate() {
        var evaluator: Evaluator = .default
        evaluator.angleMeasurementMode = UserDefaults.standard.integer(forKey: "angle_type") == 1 ? .degrees : .radians
        
        invalidCount = 0
        
        var x0 = [Double]()
        var params = [Double]()
        var t = [Double]()
        
        for inputType in 0..<inputs.count {
            for index in 0..<inputs[inputType].count {
                var text = inputs[inputType][index].value
                if text == "" {
                    if inputType == 0 {
                        switch index {
                        case 0:
                            text = "0"
                        case 1:
                            text = "1"
                        default:
                            text = "0.01"
                        }
                    } else {
                        text = "0"
                    }
                }
                
                text = text.replacingOccurrences(of: "^", with: "**")
                text = text.replacingOccurrences(of: "√", with: "sqrt")
                text = text.replacingOccurrences(of: "𝛑", with: "pi()")
                text = text.replacingOccurrences(of: "e", with: "e()")
                
                do {
                    let expression = try Expression(string: text)
                    var answerElement = try evaluator.evaluate(expression)
                    
                    if answerElement.floatingPointClass == .quietNaN {
                        inputs[inputType][index].isInvalid = true
                        invalidCount += 1
                    } else if inputType == 0 {
                        if index == 3 && answerElement < 0.01 {
                            isTimeIntervalInvalid = true
                        } else {
                            isTimeIntervalInvalid = false
                        }
                    } else {
                        inputs[inputType][index].isInvalid = false
                    }
                    
                    if loadedPreset != nil {
                        if (inputType == 1 && loadedPreset!.parameters[index].1) || (inputType == 2 && loadedPreset!.initial[index].1) {
                            if angleType == 1 {
                                answerElement = answerElement * .pi / 180
                            }
                        }
                    }
                    
                    switch inputType {
                    case 0:
                        t.append(answerElement)
                    case 1:
                        params.append(answerElement)
                    case 2:
                        x0.append(answerElement)
                    default:
                        x0.append(answerElement)
                    }
                } catch {
                    isInvalid = true
                    inputs[inputType][index].isInvalid = true
                    return
                }
            }
        }
        
        if (t[1] - t[0]) > 600 {
            isTimeSpanInvalid = true
            inputs[0][0].isInvalid = true
            inputs[0][1].isInvalid = true
            return
        } else if t[0] >= t[1] {
            isTimeSpanInvalid = true
            inputs[0][0].isInvalid = true
            inputs[0][1].isInvalid = true
            return
        } else {
            isTimeSpanInvalid = false
            inputs[0][0].isInvalid = false
            inputs[0][1].isInvalid = false
        }
        
        if t[2] < (t[1] - t[0])/6000 {
            isTimeIntervalInvalid = true
            inputs[0][2].isInvalid = true
            return
        } else {
            isTimeIntervalInvalid = false
            inputs[0][2].isInvalid = false
        }
        
        var model: (_ t: Double, _ x: [Double], _ params: [Double]) -> [Double]
        
        if loadedPreset == nil {
            switch order {
            case 1:
                model = Solver().ODEModel1(t:x:params:)
            case 2:
                model = Solver().ODEModel2(t:x:params:)
            case 3:
                model = Solver().ODEModel3(t:x:params:)
            default:
                model = Solver().ODEModel1(t:x:params:)
            }
        } else {
            model = loadedPreset?.model ?? Solver().ODEModel1(t:x:params:)
        }
        
        let output = Solver().RungeKutta(model: model, x0: x0, t: t, params: params)
        
        let formatter = NumberFormatter()
        
        if useSigFigs {
            formatter.usesSignificantDigits = true
            formatter.minimumSignificantDigits = 1
            formatter.maximumSignificantDigits = precision
        } else {
            formatter.usesSignificantDigits = false
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = precision
        }
        
        formatter.numberStyle = .decimal
        var answerArray = output.1.last ?? [Double.nan]
        
        if loadedPreset != nil {
            for value in 0..<loadedPreset!.initial.count {
                if loadedPreset!.initial[value].1 {
                    answerArray[value] = answerArray[value] * 180 / .pi
                }
            }
        }
        
        answer = answerArray.map{
            abs($0) != 0 && (abs($0) > 1000 || abs($0) < 0.001) ?
                "\(formatter.string(from: NSNumber(value: $0/pow(10, log10($0).rounded(.down)))) ?? "NaN")e\(Int(floor(log10($0))))" :
                formatter.string(from: NSNumber(value: $0)) ?? "NaN"
        }
        
        if inputs[1...].flatMap({$0}).map({$0.isInvalid}).contains(true) {
            isInvalid = true
        } else {isInvalid = false}
        
        print(inputs[1...].flatMap({$0}).map({$0.isInvalid}))
    }
}
