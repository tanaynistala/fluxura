//
//  Standard.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/16/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct Standard: View {
    @EnvironmentObject var data: AppData
    
    var body: some View {
        HStack {
                Spacer()
                VStack(spacing: 8) {
                    HStack {
                        KeyboardTextButton(label: "(", size: 44, text: "(").environmentObject(AppData.shared)
                        KeyboardTextButton(label: ")", size: 44, text: ")").environmentObject(AppData.shared)
                        KeyboardTextButton(label: "7", size: 44, text: "7").environmentObject(AppData.shared)
                        KeyboardTextButton(label: "8", size: 44, text: "8").environmentObject(AppData.shared)
                        KeyboardTextButton(label: "9", size: 44, text: "9").environmentObject(AppData.shared)
                        KeyboardImageButton(label: "divide", size: 44, text: "/").environmentObject(AppData.shared)
                    }
                    HStack {
                        KeyboardTextButton(label: "log", size: 44, text: "log(").environmentObject(AppData.shared)
                        KeyboardTextButton(label: "ln", size: 44, text: "ln(").environmentObject(AppData.shared)
                        KeyboardTextButton(label: "4", size: 44, text: "4").environmentObject(AppData.shared)
                        KeyboardTextButton(label: "5", size: 44, text: "5").environmentObject(AppData.shared)
                        KeyboardTextButton(label: "6", size: 44, text: "6").environmentObject(AppData.shared)
                        KeyboardImageButton(label: "multiply", size: 44, text: "*").environmentObject(AppData.shared)
                    }
                    HStack {
                        KeyboardImageButton(label: "chevron.up", size: 44, text: "^").environmentObject(AppData.shared)
                        KeyboardImageButton(label: "x.squareroot", size: 44, text: "√(").environmentObject(AppData.shared)
                        KeyboardTextButton(label: "1", size: 44, text: "1").environmentObject(AppData.shared)
                        KeyboardTextButton(label: "2", size: 44, text: "2").environmentObject(AppData.shared)
                        KeyboardTextButton(label: "3", size: 44, text: "3").environmentObject(AppData.shared)
                        KeyboardImageButton(label: "minus", size: 44, text: "-").environmentObject(AppData.shared)
                    }
                    HStack {
                        KeyboardTextButton(label: "𝛑", size: 44, text: "𝛑").environmentObject(AppData.shared)
                        KeyboardTextButton(label: "e", size: 44, text: "e").environmentObject(AppData.shared)
                        Button(action: {
                            self.data.editFormula(text: "0")
                            if UserDefaults.standard.bool(forKey: "keyboard_haptics_enabled") {
                                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                            }
                        }) {
                            Text("0")
                                .font(Font.system(.title, design: .default).weight(.bold))
                                .lineLimit(1)
                                .frame(width: 104, height: 44)
                                .padding(4)
                                .foregroundColor(.primary)
                                .background(
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .foregroundColor(Color(.systemGray4))
                                )
                        }
                        .buttonStyle(KeyboardButtonStyle())
                        KeyboardTextButton(label: ".", size: 44, text: ".").environmentObject(AppData.shared)
                        KeyboardImageButton(label: "plus", size: 44, text: "+").environmentObject(AppData.shared)
                    }
                }
                Spacer()
            }
    }
}

struct Standard_Previews: PreviewProvider {
    static var previews: some View {
        Standard().environmentObject(AppData())
    }
}
