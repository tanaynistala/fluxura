//
//  InputViews.swift
//  Fluxura
//
//  Created by Tanay Nistala on 7/20/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

/*
struct NativeEntryView: View {
    @EnvironmentObject var data: AppData

    var body: some View {
        ForEach(0..<self.data.order, id: \.self) { coefficient in
            HStack {
                TextField("Enter coefficient \(coefficient+1)", text: self.$data.coefficients[coefficient])

                Spacer()

                if self.data.coefficients[coefficient].count > 0 {
                    ClearButton(coefficient: coefficient)
                }

                Text("y")
                    +
                    Text(self.data.type == 1 ? "(\(coefficient))" : String(repeating: "x", count: coefficient))
                        .font(.footnote)
                        .baselineOffset(6.0 * (self.data.type == 1 ? 1 : -1))
            }
        }
    }
}
*/

struct Placeholder: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    var target: Input
    var isActive: Bool = false
    var defaultValue: String = ""
    
    init(target: Input, isActive: Bool) {
        switch target.type {
        case 0:
            switch target.index {
            case 0:
                defaultValue = "0"
            case 1:
                defaultValue = "1"
            default:
                defaultValue = "0.01"
            }
        default:
            defaultValue = "0"
        }
        
        self.target = target
        self.isActive = isActive
    }
    
    var body: some View {
        Text(defaultValue)
            .foregroundColor(
                self.reduceTransparency ? (isActive ? .white : .primary) : (isActive && !UserDefaults.standard.bool(forKey: "reduce_colors") ?
                    Color(UserDefaults.standard.string(forKey : "app_tint") ?? "indigo") :
                    Color(.placeholderText))
            )
    }
}

struct InputView: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    var target: Input
    @State var isActive: Bool = false
    let letters = (97...131).map({Character(UnicodeScalar($0))})
    
    var body: some View {
        HStack {
            Group {
                if target.type == 1 {
                    if self.data.loadedPreset == nil {
                        Text("\(String(letters[target.index])) = ")
                    } else {
                        Text("\(self.data.loadedPreset?.parameters[target.index] ?? "") = ")
                    }
                } else if target.type == 2 {
                    if self.data.loadedPreset == nil {
                        if self.data.type == 1 {
                            Group {
                                Text("f ").italic()
                                    +
                                Text("(\(target.index))")
                                    .italic()
                                    .font(Font.system(.footnote, design: .serif))
                                    .baselineOffset(6.0)
                                +
                                Text(" = ")
                            }
                            .font(Font.system(.body, design: .serif))
                        } else {
                            CoefficientsList().list[self.data.vars - 1][target.index]
                                .font(Font.system(.body, design: .serif))
                                .italic()
                            +
                            Text(" = ")
                        }
                    } else {
                        if target.index < self.data.inputs[2].count {
                            Text("\(self.data.loadedPreset?.initial[target.index] ?? "") = ")
                        }
                    }
                } else {
                    Text("\(target.index == 0 ? "Initial " : (target.index == 1 ? "Final " : ""))Time\(target.index == 2 ? " Interval" : ""): ")
                }
            }
            .foregroundColor(self.reduceTransparency && isActive ? .white : .primary)
            
            if target.value.count <= 0 {
                Placeholder(
                    target: target,
                    isActive: self.data.activeInput == [target.type, target.index]
                ).environmentObject(AppData.shared)
                .font(UserDefaults.standard.bool(forKey: "large_text") ? Font.system(.title, design: .monospaced).weight(.semibold) : Font.system(.headline, design: .monospaced))
            } else {
                ZStack(alignment: .leading) {
                    Text("\(target.value)")
                    .foregroundColor(
                        self.reduceTransparency ? (isActive ? .white : .primary) : (isActive && !UserDefaults.standard.bool(forKey: "reduce_colors") ?
                        Color(UserDefaults.standard.string(forKey : "app_tint") ?? "indigo") :
                            .primary)
                    )
                    
                    if self.data.activeInput == [target.type, target.index] {
                        Group {
                            Text(
                                String(
                                    self.data.inputs[target.type][target.index]
                                        .value.prefix(target.cursorLocation)
                                )
                            )
                                .foregroundColor(.clear)
                                +
                            Text("_")
                                .fontWeight(.black)
                        }
                        .offset(x: 2)
                        .foregroundColor(
                            UserDefaults.standard.bool(forKey: "reduce_colors") ?
                                Color.primary :
                                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                        )
                    }
                }
                .font(UserDefaults.standard.bool(forKey: "large_text") ? Font.system(.title, design: .monospaced).weight(.semibold) : Font.system(.headline, design: .monospaced))
            }
            
            Spacer()
            
            if target.type == 0 {
                Text("sec")
            }
        }
    }
}
