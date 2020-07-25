//
//  AppData.swift
//  Fluxion
//
//  Created by Tanay Nistala on 6/18/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import MathParser

class AppData: ObservableObject {
    // Input Values
    @Published var inputs = [[
        Input(type: 0, index: 0, value: "", cursorLocation: 0),
        Input(type: 0, index: 1, value: "", cursorLocation: 0),
        Input(type: 0, index: 2, value: "", cursorLocation: 0)
    ], [], []]
    
    @Published var answer = [0.0]
    
    // Data Entry
    @Published var inputCount1 = 1
    @Published var inputCount2 = 1
    @Published var activeInput = [0, 0] {
        didSet {
            if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
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
    
    
    let coefficientCount: [[Int]] = [
        [1, 2, 3, 4],
        [2, 5, 9, 14],
        [3, 9, 19, 34]
    ]
    
    // Misc. Settings
    @Published var angleType = UserDefaults.standard.integer(forKey: "angle_type") {
        didSet { UserDefaults.standard.set(angleType, forKey: "angle_type") }
    }
    @Published var useSigFigs = UserDefaults.standard.bool(forKey: "precision_type") {
        didSet { UserDefaults.standard.set(angleType, forKey: "precision_type") }
    }
    @Published var precision = UserDefaults.standard.integer(forKey: "precision") {
        didSet { UserDefaults.standard.set(precision, forKey: "precision") }
    }
    @Published var showMenu = UserDefaults.standard.bool(forKey: "show_menu") {
        didSet { UserDefaults.standard.set(showMenu, forKey: "show_menu") }
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
        if type == 1 {
            inputCount2 = order
            inputCount1 = order+1
        } else {
            inputCount2 = coefficientCount[vars-1][order-1]
            inputCount1 = inputCount2 + 1
        }

        while inputCount1 > inputs[1].count {
            inputs[1].append(Input(type: 1, index: inputs[1].count, value: "", cursorLocation: 0))
        }
        
        while inputCount1 < inputs[1].count {
            inputs[1].removeLast()
        }
        
        while inputCount2 > inputs[2].count {
            inputs[2].append(Input(type: 2, index: inputs[2].count, value: "", cursorLocation: 0))
        }
        
        while inputCount2 < inputs[2].count {
            inputs[2].removeLast()
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
                    let formatter = NumberFormatter()
                    
                    if useSigFigs {
                        formatter.minimumSignificantDigits = 1
                        formatter.maximumSignificantDigits = precision
                    } else {
                        formatter.minimumFractionDigits = 0
                        formatter.maximumFractionDigits = precision
                    }
                    
                    formatter.numberStyle = .decimal
                    
                    let expression = try Expression(string: text)
                    let answer = try evaluator.evaluate(expression)
//                        formatter.string(from: try evaluator.evaluate(expression) as NSNumber) ?? "n/a"
    //                    String(format: "%.\(UserDefaults.standard.integer(forKey: "precision"))f", try evaluator.evaluate(expression))
                    
//                    inputs[inputType][index].value = answer
//                    inputs[inputType][index].cursorLocation = answer.count
                    
                    switch inputType {
                    case 0:
                        t.append(answer)
                    case 1:
                        params.append(answer)
                    case 2:
                        x0.append(answer)
                    default:
                        x0.append(answer)
                    }
                } catch {
                    inputs[type][index].value = "0"
                }
            }
        }
        
        var model: (_ t: Double, _ x: [Double], _ params: [Double]) -> [Double]
        switch order {
        case 1:
            model = ODE().ODEModel1(t:x:params:)
        case 2:
            model = ODE().ODEModel2(t:x:params:)
        case 3:
            model = ODE().ODEModel3(t:x:params:)
        default:
            model = ODE().ODEModel1(t:x:params:)
        }
        
        let output = Solver().RungeKutta(model: model, x0: x0, t: t, params: params)
        print(output)
        answer = output.1.last ?? [0.0]
    }
}
