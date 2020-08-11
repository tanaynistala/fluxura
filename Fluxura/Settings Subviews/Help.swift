//
//  Help.swift
//  Fluxura
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
                                .foregroundColor(self.selected == 1 ? Color(.systemIndigo) : Color(.systemGray5))
                                .opacity(0.7)
                                .onTapGesture { self.selected = 1 }
                            Divider()
                            Rectangle()
                                .foregroundColor(self.selected == 2 ? Color(.systemIndigo) : Color(.systemGray5))
                                .opacity(0.7)
                                .onTapGesture { self.selected = 2 }
                            Divider()
                            Rectangle()
                                .foregroundColor(self.selected == 3 ? Color(.systemIndigo) : Color(.systemGray5))
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
                        Text("Setting the type of differential equation")
                            .font(.headline)
//                        Text("Use the picker to set the kind of differential equation (Ordinary or Partial), the order (max. 4), the number of variables (only for mixed PDEs), and whether it's linear or nonlinear (coming soon).")
                        Text("Set the order of the ODE with the stepper. We support up to 4th order ODEs. Support for PDEs, configurable variables, and linearity is coming soon.")
                        Image("Configuration")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding()
                            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 5, y: 2)
                    }
                }
                
                Card {
                    VStack(alignment: .leading) {
                        Text("Entering formulae quickly")
                            .font(.headline)
                        Text("Use the custom keyboard to enter standard and trigonometric functions and navigate entries. If it's getting in your way, swipe it down and out.")
                        Image("Keyboard")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 48))
                            .padding()
                            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 5, y: 2)
                    }
                }
                
                Card {
                    VStack(alignment: .leading) {
                        Text("Using preset differential equations")
                            .font(.headline)
                        if !UserDefaults.standard.bool(forKey: "pro") {
                            Text("Fluxura Pro feature")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(4)
                            .foregroundColor(
                                UserDefaults.standard.bool(forKey: "reduce_colors") ?
                                Color.gray :
                                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                            )
                            .background(
                                UserDefaults.standard.bool(forKey: "reduce_colors") ?
                                    Color.gray.opacity(0.2) :
                                    Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo").opacity(0.2)
                            )
                            .cornerRadius(4)
                                .padding(.vertical, 8)
                        }
                        Text("Tap on the presets icon in the top right to browse and load common differential equations from physics, chemistry, biology, and economics. Long press on the filters icon in the top right to filter by subject, or load the Generic preset for custom ODEs.")
                        Image("Presets")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding()
                            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 5, y: 2)
                    }
                }
                
                Card {
                    VStack(alignment: .leading) {
                        Text("Loading Presets")
                            .font(.headline)
                        Text("Use the plus button at the top or the 'Load Preset' button at the bottom of a preset's page to load it.")
                        Image("Load Preset")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding()
                            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 5, y: 2)
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
    @Environment(\.colorScheme) var colorScheme

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding()
            .background(Color(.tertiarySystemGroupedBackground))
            .cornerRadius(16)
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Help()
        }
        .environment(\.colorScheme, .light)
    }
}
