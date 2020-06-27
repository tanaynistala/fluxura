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
    @Published var order = 1
    @Published var isLinear = true
    @Published var keyboardView: Int = 1
    @Published var type = 1 {
        didSet {
            if self.type == 1 && self.activeInput > 3 {
                self.activeInput = 3
            }
            
            if self.type == 1 && self.inputs.count > 4 {
                self.inputs.removeLast(self.inputs.count - 4)
            }
            
            if self.type == 1 && self.order > 4 {
                self.order = 4
            }
        }
    }
    @Published var reduceColors = UserDefaults.standard.bool(forKey: "reduce_colors")
    @Published var appTint = UserDefaults.standard.string(forKey: "app_tint")
    @Published var currentPage: String
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = "onboardingView"
        } else {
            currentPage = "homeView"
        }
    }
    
    func refresh() {
        reduceColors = UserDefaults.standard.bool(forKey: "reduce_colors")
        appTint = UserDefaults.standard.string(forKey: "app_tint")
    }
    
    func editFormula(text: String) {
        self.inputs[self.activeInput].insert(contentsOf: text, at: self.inputs[self.activeInput].index(self.inputs[self.activeInput].startIndex, offsetBy: self.cursorPos))
        self.cursorPos += text.count
    }
}
