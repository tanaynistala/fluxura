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
                    
                    if UserDefaults.standard.bool(forKey: "pro") {
                        Button(action: {
                            self.data.loadedPreset = self.preset
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "plus.circle")
                                .imageScale(.large)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo"))
                                .font(.headline)
                        }
                    } else {
                        NavigationLink(destination:
                            ProPreview()
                                .environmentObject(SubscriptionManager.shared)) {
                           Image(systemName: "plus.circle")
                           .imageScale(.large)
                           .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo"))
                           .font(.headline)
                        }
                    }
                }
                
                Text(preset.description)
                    .padding(.bottom, 2)
                
                Button(action: {
                    UIApplication.shared.open(URL(string: self.preset.url)!)
                }) {
                    HStack {
                        Text("Read more")
                        Image(systemName: "arrow.up.right.circle.fill")
                    }
                    .foregroundColor(
                        UserDefaults.standard.bool(forKey: "reduce_colors") ?
                            Color.gray :
                            Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                    )
                    .padding(4)
                    .padding(.horizontal, 4)
                    .background(
                        UserDefaults.standard.bool(forKey: "reduce_colors") ?
                            Color.gray.opacity(0.3) :
                            Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo").opacity(0.3)
                    )
                    .cornerRadius(8)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "\(self.preset.parameters.count + self.preset.initial.count).square")
                            .imageScale(.large)
                        Text("Parameters")
                        Spacer()
                    }
                    .font(.headline)
                    
                    ForEach(preset.inputDescription, id: \.self) { input in
                        HStack(spacing: 16) {
                            Image(systemName: "number")
                            VStack(alignment: .leading) {
                                Text(input[0])
                                    
                                Text(input[1])
                                    .font(.footnote)
                            }
                        }
                    }
                }
            
                Spacer()
                
                if UserDefaults.standard.bool(forKey: "pro") {
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
                                .fill(UserDefaults.standard.bool(forKey: "reduce_colors") ? Color(.tertiarySystemGroupedBackground) : Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")))
                            .padding(.bottom)
                    }
                } else {
                    NavigationLink(destination:
                        ProPreview()
                        .environmentObject(SubscriptionManager.shared)) {
                        Text("Load Preset")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(UserDefaults.standard.bool(forKey: "reduce_colors") ? Color(.tertiarySystemGroupedBackground) : Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")))
                            .padding(.bottom)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle(Text(preset.name), displayMode: .inline)
    }
}

struct PresetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PresetDetailView(preset: Presets().presets[3])
                .environmentObject(AppData())
        }
    }
}
