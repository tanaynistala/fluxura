//
//  ClearFieldsView.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/20/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct ClearFieldsView: View {
    @EnvironmentObject var data: AppData
    @State var showClearAlert = false
    
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
            ActionSheet(title: Text("Are you sure?"), message: Text("This will clear all fields."), buttons: [
                .destructive(Text("Clear"), action: {
                    for input in 0..<self.data.inputs.count {
                        self.data.inputs[input] = ""
                        self.data.cursorPos = 0
                    }
                }),
                .cancel()
            ])
        }
    }
}

struct ResetFieldsView: View {
    @EnvironmentObject var data: AppData
    @State var showResetAlert = false
    
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
        .actionSheet(isPresented: $showResetAlert) {
            ActionSheet(title: Text("Are you sure?"), message: Text("This will clear all fields and reset the equation settings."), buttons: [
                .destructive(Text("Reset"), action: {
                    self.data.type = 1
                    self.data.cursorPos = 0
                    self.data.activeInput = 0
                    self.data.order = 1
                    self.data.vars = 1
                    self.data.inputs[0] = ""
                }),
                .cancel()
            ])
        }
    }
}

struct ClearFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        ClearFieldsView()
    }
}
