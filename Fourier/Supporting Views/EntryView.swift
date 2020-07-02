//
//  CoefficientsView.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/18/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        ForEach(0..<self.data.inputCount, id: \.self) { coefficient in
            HStack {
                if self.data.inputs[coefficient].count <= 0 {
                    Placeholder(coefficient: coefficient).environmentObject(self.data)
                } else {
                    InputView(coefficient: coefficient).environmentObject(self.data)
                }
                
                Spacer()
                
                if self.data.inputs[coefficient].count > 0 {
                    ClearButton(coefficient: coefficient)
                }
                
                if self.data.type == 1 {
                    Group {
                        Text("f ").italic()
                            +
                        Text("(\(coefficient))")
                            .font(Font.system(.footnote, design: .serif))
                            .baselineOffset(6.0)
                    }
                    .font(Font.system(.body, design: .serif))
                } else {
                    CoefficientsList().list[self.data.vars - 1][coefficient]
                        .font(Font.system(.body, design: .serif))
                }
            }
            .listRowBackground(
                Group {
                    self.data.activeInput == coefficient ? (
                        self.data.reduceColors ?
                        Color(UIColor.systemFill).opacity(self.reduceTransparency ? 1 : 0.8) :
                        Color(self.data.appTint ?? "indigo").opacity(self.reduceTransparency ? 1 : 0.2)
                    ) : Color.clear
                }
                .animation(.spring())
            )
            .onTapGesture {
                self.data.activeInput = coefficient
                self.data.cursorPos = self.data.inputs[coefficient].count
            }
            .accessibility(addTraits: .updatesFrequently)
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            EntryView()
                .environmentObject(AppData())
        }
    }
}

struct NativeEntryView: View {
    @EnvironmentObject var data: AppData
    
    var body: some View {
        ForEach(0..<self.data.order, id: \.self) { coefficient in
            HStack {
                TextField("Enter coefficient \(coefficient+1)", text: self.$data.inputs[coefficient])
                
                Spacer()
                
                if self.data.inputs[coefficient].count > 0 {
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

struct Placeholder: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    var coefficient: Int = 0
    
    var body: some View {
        Text("Enter coefficient \(coefficient+1)...")
            .foregroundColor(
                self.reduceTransparency ? .primary : (self.data.activeInput == coefficient && !UserDefaults.standard.bool(forKey: "reduce_colors") ?
                    Color(UserDefaults.standard.string(forKey : "app_tint") ?? "indigo") :
                    Color(UIColor.placeholderText))
            )
    }
}

struct InputView: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @State var coefficient: Int = 0
    @State var width: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("\(String(self.data.inputs[min(self.data.order-1, self.coefficient)]))")
            .foregroundColor(
                self.reduceTransparency ? .primary : (self.data.activeInput == self.coefficient && !UserDefaults.standard.bool(forKey: "reduce_colors") ?
                Color(UserDefaults.standard.string(forKey : "app_tint") ?? "indigo") :
                    Color.primary)
            )
            
            if self.data.activeInput == self.coefficient {
                Group {
                    Text("\(String(self.data.inputs[self.coefficient][..<self.data.inputs[self.coefficient].index(self.data.inputs[self.coefficient].startIndex, offsetBy: self.data.cursorPos)]))").foregroundColor(.clear)
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
        .font(UserDefaults.standard.bool(forKey: "large_text") ? Font.system(.title).weight(.semibold) : Font.headline)
    }
}

struct ClearButton: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @State var coefficient: Int = 0
    
    var body: some View {
        Button(action: {
            self.data.inputs[self.coefficient] = ""
            self.data.cursorPos = 0
        }) {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(
                    self.reduceTransparency ? Color.primary : (self.data.activeInput == self.coefficient && !UserDefaults.standard.bool(forKey: "reduce_colors") ?
                    Color(UserDefaults.standard.string(forKey : "app_tint") ?? "indigo") :
                        Color(UIColor.placeholderText))
                )
        }.buttonStyle(BorderlessButtonStyle())
            .accessibility(label: Text("Clear"))
    }
}
