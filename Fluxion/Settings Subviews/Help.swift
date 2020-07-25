//
//  Help.swift
//  Fluxion
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
            VStack(alignment: .leading, spacing: 24) {
                Card {
                    VStack(alignment: .leading) {
                        Text("Tap to select a field")
                            .font(.headline)
                        Text("Tap on a field to select it. The selected field is highlighted in your accent color. Try it below!")
                        
                        VStack(spacing: 0) {
                            Rectangle()
                                .foregroundColor(self.selected == 1 ? Color(UIColor.systemIndigo) : Color(UIColor.systemGray4))
                                .opacity(0.7)
                                .onTapGesture { self.selected = 1 }
                            Divider()
                            Rectangle()
                                .foregroundColor(self.selected == 2 ? Color(UIColor.systemIndigo) : Color(UIColor.systemGray4))
                                .opacity(0.7)
                                .onTapGesture { self.selected = 2 }
                            Divider()
                            Rectangle()
                                .foregroundColor(self.selected == 3 ? Color(UIColor.systemIndigo) : Color(UIColor.systemGray4))
                                .opacity(0.7)
                                .onTapGesture { self.selected = 3 }
                        }
                        .frame(height: 192)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding()
                    }
                }
                
                Card {
                    VStack(alignment: .leading) {
                        Text("Set the type of differential equation")
                            .font(.headline)
                        Text("Use the picker to set the kind of differential equation (Ordinary or Partial), the order (max. 4), the number of variables (only for mixed PDEs), and whether it's linear or nonlinear (coming soon).")
                        Image("Configuration")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding()
                    }
                }
                
                Card {
                    VStack(alignment: .leading) {
                        Text("Enter formulae quickly")
                            .font(.headline)
                        Text("Use the custom keyboard to enter standard and trigonometric functions and navigate entries. If it's getting in your way, swipe it down and out.")
                        Image("Keyboard")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 48))
                            .padding()
                    }
                }
                
                Card {
                    VStack(alignment: .leading) {
                        Text("Use common differential equations")
                            .font(.headline)
                        Text("Click on the presets icon to browse preset differential equations from physics, chemistry, biology, CS, and more!")
                        Image("Presets")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding()
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Help")
    }
}

struct Card<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding()
            .background(Color(.white))
            .cornerRadius(16)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 5, y: 2)
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}
