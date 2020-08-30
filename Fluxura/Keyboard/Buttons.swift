//
//  Buttons.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/18/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct TrigButton: View {
    @State var label: String
    @State var size: CGFloat
    @State var text: String
    @EnvironmentObject var data: AppData
    
    var body: some View {
        Button(action: {
            self.data.editFormula(text: self.text)
            if UserDefaults.standard.bool(forKey: "keyboard_haptics_enabled") {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
        }) {
            Text("\(label)")
                .font(Font.system(.title, design: .default).weight(.bold))
                .allowsTightening(true)
                .lineLimit(1)
                .frame(width: self.size*1.5 + 8, height: self.size)
                .padding(4)
                .foregroundColor(.primary)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .foregroundColor(Color(.systemGray4))
                )
        }
        .buttonStyle(KeyboardButtonStyle())
    }
}

struct KeyboardTextButton: View {
    @State var label: String
    @State var size: CGFloat
    @State var text: String
    @EnvironmentObject var data: AppData
    
    var body: some View {
        Button(action: {
            self.data.editFormula(text: self.text)
            if UserDefaults.standard.bool(forKey: "keyboard_haptics_enabled") {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
        }) {
            Text("\(label)")
                .font(Font.system(.title, design: .default).weight(.bold))
                .allowsTightening(true)
                .frame(width: self.size, height: self.size)
                .padding(4)
                .foregroundColor(.primary)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .foregroundColor(Color(.systemGray4))
                )
        }
        .buttonStyle(KeyboardButtonStyle())
    }
}

struct KeyboardImageButton: View {
    @State var label: String
    @State var size: CGFloat
    @State var text: String
    @EnvironmentObject var data: AppData
    
    var body: some View {
        Button(action: {
            self.data.editFormula(text: self.text)
            if UserDefaults.standard.bool(forKey: "keyboard_haptics_enabled") {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
        }) {
            Image(systemName: "\(label)")
                .font(Font.system(.title).weight(.bold))
                .frame(width: self.size, height: self.size)
                .padding(4)
                .foregroundColor(.primary)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .foregroundColor(Color(.systemGray4))
                )
        }
        .buttonStyle(KeyboardButtonStyle())
    }
}

struct KeyboardButtonStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(self.reduceMotion || UserDefaults.standard.bool(forKey: "reduce_motion") ? nil : .interactiveSpring())
            .accessibility(addTraits: .isKeyboardKey)
    }
}

struct IconButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(4)
            .background(configuration.isPressed ? Color(.systemGray3) : Color.clear)
            .cornerRadius(8)
    }
}
