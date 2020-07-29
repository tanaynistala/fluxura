//
//  KeyboardView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/15/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Picker(selection: self.$data.keyboardView, label: Text("Keyboard")) {
                    Text("Standard").tag(1)
                    Text("Extended").tag(2)
                }
                .animation(nil)
                .fixedSize(horizontal: true, vertical: false)
                .pickerStyle(SegmentedPickerStyle())
                
                Button(action: {
                    if self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].cursorLocation > 0 {
                        self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].cursorLocation -= 1
                    }
                    
                    if UserDefaults.standard.bool(forKey: "keyboard_haptics_enabled") {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .font(.headline)
                        .frame(width: 24, height: 24)
                        .foregroundColor(self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].cursorLocation > 0 ? .primary : .gray)
                }
                .buttonStyle(IconButtonStyle())
                .disabled(!(self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].cursorLocation > 0))
                .accessibility(label: Text("Scroll Left"))
                
                Button(action: {
                    if self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].cursorLocation < self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].value.count {
                        self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].cursorLocation += 1
                    }
                    
                    if UserDefaults.standard.bool(forKey: "keyboard_haptics_enabled") {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .imageScale(.large)
                        .font(.headline)
                        .frame(width: 24, height: 24)
                        .foregroundColor(self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].cursorLocation < self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].value.count ? .primary : .gray)
                }
                .buttonStyle(IconButtonStyle())
                .disabled(!(self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].cursorLocation < self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].value.count))
                .accessibility(label: Text("Scroll Right"))
                
                Button(action: {
                    if self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].cursorLocation > 0 {
                        self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].value.remove(at: self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].value.index(self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].value.startIndex, offsetBy: self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].cursorLocation-1))
                        self.data.inputs[self.data.activeInput[0]][self.data.activeInput[1]].cursorLocation -= 1
                    }
                    
                    if UserDefaults.standard.bool(forKey: "keyboard_haptics_enabled") {
                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                    }
                }) {
                    Image(systemName: "delete.left.fill")
                        .imageScale(.large)
                        .font(.headline)
                        .frame(width: 44, height: 24)
                        .foregroundColor(Color(UIColor.systemRed))
                }
                .buttonStyle(IconButtonStyle())
                .accessibility(label: Text("Delete"))
                
                Button(action: {
                    if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    
                    self.data.calculate()
                }) {
                    Image(systemName: "arrow.right")
                        .imageScale(.large)
                        .font(.headline)
                        .frame(width: 44, height: 24)
                        .padding(4)
                        .foregroundColor(
//                            self.data.inputs.contains("") ? Color.gray :
                            (self.data.reduceColors ? Color.black : Color.white)
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                        )
                }
//                .disabled(self.data.coefficients.contains(""))
                .buttonStyle(KeyboardButtonStyle())
                .foregroundColor(
//                    self.data.coefficients.contains("") ? Color(UIColor.systemGray4) :
                        (self.data.reduceColors ?
                    Color(UIColor.systemGray4) :
                        Color(self.data.appTint ?? "indigo"))
                )
                .animation(self.reduceMotion || UserDefaults.standard.bool(forKey: "reduce_motion") ? nil : .easeInOut)
                .accessibility(label: Text("Calculate"))
            }
            
//            Divider()
            
            if !self.data.isLinear {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<self.data.order, id: \.self) { diff in
                            Button(action: {}) {
                                Group {
                                    Text("y")
                                    +
                                    Text("(\(diff))")
                                        .font(.footnote)
                                        .baselineOffset(6.0)
                                }
                                .frame(width: 24, height: 24)
                                .padding(4)
                                .foregroundColor(.primary)
                                .background(
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .foregroundColor(Color(UIColor.systemGray4))
                                )
                            }
                        }
                    }.padding(.horizontal)
                }
            }
            
            Divider()
            
            if self.data.keyboardView == 1 {
                Standard().environmentObject(self.data)
            } else if self.data.keyboardView == 2 {
                Extended().environmentObject(self.data)
            }
        }
        .padding(.vertical)
        .padding(.bottom)
//        .background(
//            RoundedRectangle(cornerRadius: 16)
//                .frame(width: UIScreen.main.bounds.size.width)
//                .foregroundColor(Color(UIColor.systemGray6))
//                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.25), radius: 2, y: -2)
//        )
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
            .environmentObject(AppData())
    }
}