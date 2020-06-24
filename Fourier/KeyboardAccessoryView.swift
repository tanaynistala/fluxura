//
//  KeyboardAccessoryView.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/24/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct KeyboardAccessoryView: View {
    @EnvironmentObject var data: AppData
    var standardShortcuts: [Shortcut] = [
        Shortcut(isImage: true, label: "plus", text: "+"),
        Shortcut(isImage: true, label: "minus", text: "-"),
        Shortcut(isImage: true, label: "multiply", text: "*"),
        Shortcut(isImage: true, label: "divide", text: "/"),
        Shortcut(isImage: true, label: "chevron.up", text: "^"),
        Shortcut(isImage: true, label: "x.squareroot", text: "sqrt("),
        Shortcut(isImage: false, label: "(", text: "("),
        Shortcut(isImage: false, label: ")", text: ")"),
        Shortcut(isImage: false, label: "𝛑", text: "𝛑"),
        Shortcut(isImage: false, label: "e", text: "e"),
        Shortcut(isImage: false, label: "log", text: "log("),
        Shortcut(isImage: false, label: "ln", text: "ln(")
    ]
    
    var extendedShortcuts: [Shortcut] = [
        Shortcut(isImage: false, label: "sin", text: "sin("),
        Shortcut(isImage: false, label: "cos", text: "cos("),
        Shortcut(isImage: false, label: "tan", text: "tan("),
        Shortcut(isImage: false, label: "csc", text: "csc("),
        Shortcut(isImage: false, label: "sec", text: "sec("),
        Shortcut(isImage: false, label: "cot", text: "cot("),
        Shortcut(isImage: false, label: "asin", text: "asin("),
        Shortcut(isImage: false, label: "acos", text: "acos("),
        Shortcut(isImage: false, label: "atan", text: "atan("),
        Shortcut(isImage: false, label: "acsc", text: "acsc("),
        Shortcut(isImage: false, label: "asec", text: "asec("),
        Shortcut(isImage: false, label: "acot", text: "acot(")
    ]
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Picker(selection: self.$data.keyboardView, label: Text("Keyboard")) {
                    Text("Standard").tag(1)
                    Text("Extended").tag(2)
                }
                .fixedSize(horizontal: true, vertical: false)
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                
                Button(action: {
                    if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                }) {
                    Image(systemName: "arrow.right")
                        .imageScale(.large)
                        .font(.headline)
                        .frame(width: 44, height: 24)
                        .padding(4)
                        .foregroundColor(
                            self.data.reduceColors ? Color.black : Color.white
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                        )
                }
                
                .foregroundColor(
                    self.data.reduceColors ?
                    Color(UIColor.systemGray4) :
                        Color(self.data.appTint ?? "blue")
                )
                .accessibility(label: Text("Calculate"))
            }.padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(self.data.keyboardView == 1 ? standardShortcuts : extendedShortcuts, id: \.self) { shortcut in
                        shortcut
                    }
                }.padding(.horizontal)
            }
            
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
                                .frame(width: 32, height: 32)
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
        }
        .padding(.vertical)
        .background(Rectangle().foregroundColor(Color(UIColor.systemGray5)))
    }
}

struct Shortcut: View, Hashable {
    var isImage: Bool = false
    var label: String = ""
    var text: String = ""
    
    var body: some View {
        Button(action: {}) {
            if !isImage {
                Text(label)
            } else {
                Image(systemName: label)
                    .imageScale(.large)
            }
        }
        .font(.headline)
        .padding(.horizontal, 4)
        .frame(minWidth: 32, minHeight: 32, idealHeight: 32, maxHeight: 32, alignment: .center)
        .foregroundColor(.primary)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
            .colorInvert()
        )
        .animation(.none)
    }
}

struct KeyboardAccessoryView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardAccessoryView()
        .environmentObject(AppData())
    }
}
