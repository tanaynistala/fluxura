//
//  AppData.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/18/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

class AppData: ObservableObject {
    @Published var inputs: [String] = [""]
    @Published var cursorPos: Int = 0
    @Published var activeInput = 0 {
        didSet {
            if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }
        }
    }
    @Published var order = 1 {didSet {refreshEntries()}}
    @Published var vars = 1 {
        didSet {
//            inputs.removeAll()
            refreshEntries()
        }
    }
    @Published var type = 1 {
        didSet {
//            inputs.removeAll()
            refreshEntries()
        }
    }
    @Published var isLinear = true {didSet {refreshEntries()}}
    
    @Published var keyboardView: Int = 1
    @Published var reduceColors = UserDefaults.standard.bool(forKey: "reduce_colors")
    @Published var appTint = UserDefaults.standard.string(forKey: "app_tint")
    @Published var onboarding: Bool
    @Published var inputCount = 1
    
    @Published var coefficientCount: [[Int]] = [
        [1, 2, 3, 4],
        [2, 5, 9, 14],
        [3, 9, 18, 30]
    ]
    
    @Published var presetsShown = false {
        didSet {
            if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
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
    }
    
    func refresh() {
        reduceColors = UserDefaults.standard.bool(forKey: "reduce_colors")
        appTint = UserDefaults.standard.string(forKey: "app_tint")
    }
    
    func refreshEntries() {
        if type == 1 {
            inputCount = order
        } else {
            inputCount = coefficientCount[vars-1][order-1]
        }
        
        if inputCount > inputs.count {
            for _ in 0...(inputCount - inputs.count) {
                inputs.append("")
            }
        } else {
            inputs.removeLast(inputs.count - inputCount)
        }
    }
    
    func editFormula(text: String) {
        self.inputs[self.activeInput].insert(contentsOf: text, at: self.inputs[self.activeInput].index(self.inputs[self.activeInput].startIndex, offsetBy: self.cursorPos))
        self.cursorPos += text.count
    }
}
