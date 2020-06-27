//
//  Help.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/25/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct Help: View {
    @State private var selected = 1
    @State private var open = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Tap to select a field")
                    .font(.headline)
                Text("Tap on a field to select it. The selected field is highlighted in your accent color. Try it below!")
                
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(selected == 1 ? Color(UIColor.systemIndigo) : Color(UIColor.systemGray4))
                        .opacity(0.7)
                        .onTapGesture { self.selected = 1 }
                    Rectangle()
                        .foregroundColor(selected == 2 ? Color(UIColor.systemIndigo) : Color(UIColor.systemGray4))
                        .opacity(0.7)
                        .onTapGesture { self.selected = 2 }
                }
                .animation(.easeInOut)
                .frame(height: 128)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding()
                
                Text("Set the type of differential equation")
                    .font(.headline)
                Text("Use the picker to set the kind of differential equation (Ordinary or Partial), the order (max. 4 for ODEs, and max. 8 for PDEs), and whether it's linear or nonlinear (coming soon).")
                Image("Help2")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding()
                
                Text("Enter formulae quickly")
                    .font(.headline)
                Text("Use the custom keyboard to enter standard and trigonometric functions and navigate entries. If it's getting in your way, swipe it down and out.")
                Image("Keyboard")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 48))
                    .padding()
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Help")
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}
