//
//  ClearFieldsView.swift
//  Fluxion
//
//  Created by Tanay Nistala on 6/20/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct ClearFieldsView: View {
    @EnvironmentObject var data: AppData
    @State var target: Int
    @State var showClearAlert = false
    
    func clearFields() {
        for input in 0..<self.data.inputs[target].count {
            self.data.inputs[target][input] = Input(type: target, index: input, value: "", cursorLocation: 0)
        }
    }

    var body: some View {
        Button(action: {
            self.showClearAlert.toggle()
        }) {
            HStack(spacing: 4) {
                Text("Clear")
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.large)
                    .accessibility(hidden: true)
            }
            .padding(4)
        }
        .buttonStyle(IconButtonStyle())
        .actionSheet(isPresented: $showClearAlert) {
            ActionSheet(title: Text("Are you sure?"), message: Text("This will clear all fields in this section."), buttons: [
                .destructive(Text("Clear"), action: {
                    self.clearFields()
                }),
                .cancel()
            ])
        }
    }
}

struct ResetFieldsView: View {
    @EnvironmentObject var data: AppData
    @State var showResetAlert = false
    @State var showClearAlert = false
    
    var body: some View {
        Button(action: {
            self.showResetAlert.toggle()
        }) {
            HStack(spacing: 4) {
                Text("Reset")
                Image(systemName: "trash.circle.fill")
                    .imageScale(.large)
                    .accessibility(hidden: true)
            }
            .padding(4)
        }
        .buttonStyle(IconButtonStyle())
        .contextMenu {
            Button(action: {
                self.showClearAlert.toggle()
            }) {
                Text("Clear All Fields")
                Image(systemName: "clear.fill")
            }
            .actionSheet(isPresented: $showClearAlert) {
                ActionSheet(title: Text("Are you sure?"), message: Text("This will clear all fields."), buttons: [
                    .destructive(Text("Clear"), action: {
                        for type in 0..<self.data.inputs.count {
                            for input in 0..<self.data.inputs[type].count {
                                self.data.inputs[type][input] = Input(type: type, index: input, value: "", cursorLocation: 0)
                            }
                        }
                    }),
                    .cancel()
                ])
            }

            Button(action: {
                self.showResetAlert.toggle()
            }) {
                Text("Reset Configuration")
                Image(systemName: "trash.fill")
            }
            .actionSheet(isPresented: $showResetAlert) {
                ActionSheet(title: Text("Are you sure?"), message: Text("This will clear all fields and reset the equation settings."), buttons: [
                    .destructive(Text("Reset"), action: {
                        self.data.activeInput = [0, 0]
                        self.data.type = 1
                        self.data.order = 1
                        self.data.vars = 1
                    }),
                    .cancel()
                ])
            }
        }
    }
}
