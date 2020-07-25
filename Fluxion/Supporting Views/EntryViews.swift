//
//  CoefficientsView.swift
//  Fluxion
//
//  Created by Tanay Nistala on 6/18/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    var type: Int
    
    var body: some View {
        ForEach(self.data.inputs[type], id: \.self) { target in
            HStack {
                InputView(
                    target: target,
                    isActive: [target.type, target.index] == self.data.activeInput
                ).environmentObject(self.data)
                
//                if target.value.count > 0 {
//                    ClearButton(
//                        target: target
//                    )
//                }
            }
            .listRowBackground(
                Group {
                    [target.type, target.index] == self.data.activeInput ? (
                        self.data.reduceColors ?
                        Color(UIColor.systemFill).opacity(self.reduceTransparency ? 1 : 0.8) :
                        Color(self.data.appTint ?? "indigo").opacity(self.reduceTransparency ? 1 : 0.2)
                    ) : Color.clear
                }
                .animation(.spring())
            )
            .onAppear{
                UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            .onTapGesture {
                self.data.activeInput = [target.type, target.index]
            }
            .accessibility(addTraits: .updatesFrequently)
        }
    }
}

//struct CoefficientEntryView: View {
//    @EnvironmentObject var data: AppData
//    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
//
//    var body: some View {
//        ForEach(0..<self.data.inputCount, id: \.self) { coefficient in
//            HStack {
//                if self.data.coefficients[coefficient].count <= 0 {
//                    Placeholder(coefficient: coefficient).environmentObject(self.data)
//                } else {
//                    InputView(coefficient: coefficient).environmentObject(self.data)
//                }
//
//                Spacer()
//
//                if self.data.coefficients[coefficient].count > 0 {
//                    ClearButton(coefficient: coefficient)
//                }
//
//                Group {
//                    if self.data.type == 1 {
//                        Group {
//                            Text("f ").italic()
//                                +
//                            Text("(\(coefficient))")
//                                .font(Font.system(.footnote, design: .serif))
//                                .baselineOffset(6.0)
//                        }
//                        .font(Font.system(.body, design: .serif))
//                    } else {
//                        CoefficientsList().list[self.data.vars - 1][coefficient]
//                            .font(Font.system(.body, design: .serif))
//                            .fixedSize()
//                    }
//                }
//                .foregroundColor(self.reduceTransparency && self.data.activeInput == coefficient ? .white : .primary)
//            }
//            .listRowBackground(
//                Group {
//                    self.data.activeInput == coefficient ? (
//                        self.data.reduceColors ?
//                        Color(UIColor.systemFill).opacity(self.reduceTransparency ? 1 : 0.8) :
//                        Color(self.data.appTint ?? "indigo").opacity(self.reduceTransparency ? 1 : 0.2)
//                    ) : Color.clear
//                }
//                .animation(.spring())
//            )
//            .onAppear{
//                UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            }
//            .onTapGesture {
//                self.data.activeInput = coefficient
//                self.data.cursorPos = self.data.coefficients[coefficient].count
//            }
//            .accessibility(addTraits: .updatesFrequently)
//        }
//    }
//}
