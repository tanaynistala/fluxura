//
//  AppIconsView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/21/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct AppIconsView: View {
    @State var icon = UIApplication.shared.alternateIconName
    @State var showHint = true
    @State var showPreview = false
    @State var selectedIcon: SettingsStore.AppIcon = .twilight
    @State var mode: String = "Light"
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didShowHint") {
            UserDefaults.standard.set(true, forKey: "didShowHint")
            self.showHint = true
        } else {
            self.showHint = false
        }
    }
    
    var body: some View {
        ZStack {
            Form {
                if showHint {
                    Section {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Preview Icons").font(.headline)
                                Text("Tap an icon to preview it in high-resolution!").font(.footnote)
                            }
                            Spacer()
                            Button(action: {self.showHint = false}) {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(Color(UIColor.placeholderText))
                            }.buttonStyle(BorderlessButtonStyle())
                        }.padding(.vertical)
                    }
                }
                
                Section {
                    ForEach(SettingsStore.AppIcon.allCases, id: \.self) { icon in
                        Group {
                            if (self.mode == "Light" && !icon.rawValue.contains("Dark")) || (self.mode == "Dark" && icon.rawValue.contains("Dark")) {
                                HStack {
                                    Image("\(icon.rawValue)")
                                        .resizable()
                                        .renderingMode(.original)
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(width: 48, height: 48)
                                        .cornerRadius(8)
                                        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 5, y: 2)
                                        .padding([.vertical, .trailing], 8)
                                        .onTapGesture {
                                            self.selectedIcon = icon
                                            self.showPreview = true
                                        }
                                    
                                    Text("\(icon.rawValue)")
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    if self.icon == icon.rawValue {
                                        Image(systemName: "checkmark.circle.fill")
                                            .imageScale(.large)
                                            .font(.headline)
                                            .foregroundColor(
                                                UserDefaults.standard.bool(forKey: "reduce_colors") ?
                                                Color.primary :
                                                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                                            )
                                    }
                                }
                                .onTapGesture {
                                    UIApplication.shared.setAlternateIconName("\(icon.rawValue)")
                                    self.icon = UIApplication.shared.alternateIconName
                                }
                            }
                        }
                    }
                }
                .sheet(isPresented: $showPreview) {
                    VStack {
                        Spacer()
                        Image(self.selectedIcon.rawValue)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(1, contentMode: .fit)
                            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 5, y: 2)
                            .padding()
                        Spacer()
                        Button(action: {
                            self.showPreview.toggle()
                        }) {
                            Text("Dismiss")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                                .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color(UIColor.systemIndigo)))
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarTitle(Text("App Icon"))
            .padding(.bottom)
            
            VStack {
                Spacer()
                
                Picker("Mode", selection: $mode) {
                    Text("Light").tag("Light")
                    Text("Dark").tag("Dark")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .padding(.bottom)
                .background(Color(.systemGray6))
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct AppIconsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
                AppIconsView()
            .navigationBarTitle("App Icons")
                    .environment(\.horizontalSizeClass, .regular)
        }
    }
}
