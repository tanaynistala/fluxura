//
//  PresetDetailView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 7/2/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct PresetDetailView: View {
    @EnvironmentObject var data: AppData
    @Environment(\.presentationMode) var presentationMode
    var preset: Preset
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            if preset.order > 0 {
                                OrderTag(order: preset.order)
                            }
                            
                            ForEach(preset.types, id: \.self) { type in
                                TypeTag(text: type.rawValue, color: .systemOrange)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    Button(action: {
                        self.data.loadedPreset = self.preset
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "plus.circle")
                            .imageScale(.large)
                            .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color(.systemIndigo))
                            .font(.headline)
                    }
                }
                
                Text(preset.description)
                    .font(.callout)
                    .padding(.bottom, 2)
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {UIApplication.shared.open(URL(string: self.preset.url)!)}) {
                        HStack {
                            Text("Read More")
                            Image(systemName: "link")
                                .imageScale(.small)
                        }
                        .padding(4)
                    }
                    .buttonStyle(IconButtonStyle())
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Parameters")
                        .font(.title)
                    
                    ForEach(preset.inputDescription, id: \.self) { input in
                        HStack {
                            Text(input[0])
                            .bold()
                            +
                            Text(": ")
                            +
                            Text(input[1])
                            
                            Spacer()
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
            
                Spacer()
                
                Button(action: {
                    self.data.loadedPreset = self.preset
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Load Preset")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color(UIColor.systemIndigo)))
                        .padding(.bottom)
                }
            }
        .padding()
        }
        .navigationBarTitle(preset.name)
    }
}

struct PresetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PresetDetailView(preset: Presets().presets[1])
                .environmentObject(AppData())
        }
    }
}
