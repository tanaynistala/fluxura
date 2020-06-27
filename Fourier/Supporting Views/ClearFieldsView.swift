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
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                for input in 0..<self.data.inputs.count {
                    self.data.inputs[input] = ""
                    self.data.cursorPos = 0
                }
            }) {
                HStack(spacing: 4) {
                    Text("Clear All")
                    Image(systemName: "xmark.circle.fill")
                    .accessibility(hidden: true)
                }
                .padding(4)
            }
            .buttonStyle(IconButtonStyle())
            .contextMenu {
                Button(action: {
                    for input in 0..<self.data.inputs.count {
                        self.data.inputs[input] = ""
                        self.data.cursorPos = 0
                    }
                }) {
                    Text("Clear All")
                    Image(systemName: "xmark.circle")
                        .imageScale(.small)
                }
                
                Button(action: {
                    self.data.cursorPos = 0
                    self.data.activeInput = 0
                    self.data.order = 1
                    self.data.inputs = [""]
                }) {
                    Text("Reset")
                    Image(systemName: "trash.fill")
                    .imageScale(.small)
                }
            }
        }
    }
}

struct ClearFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        ClearFieldsView()
    }
}
