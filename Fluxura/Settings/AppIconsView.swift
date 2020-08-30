//
//  AppIconsView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/21/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct AppIconsView: View {
    @State var activeIcon = UIApplication.shared.alternateIconName ?? "Twilight"
    @State var showHint = true
    @State private var showPro = false
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
                Picker("Mode", selection: $mode) {
                    Text("Light").tag("Light")
                    Text("Dark").tag("Dark")
                }
                .pickerStyle(SegmentedPickerStyle())
                .listRowBackground(Color(.systemGroupedBackground))
                
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
                                    .foregroundColor(Color(.placeholderText))
                            }.buttonStyle(BorderlessButtonStyle())
                        }.padding(.vertical)
                    }
                }
                
                Section {
                    ForEach(SettingsStore.AppIcon.allCases, id: \.self) { icon in
                        Group {
                            if (self.mode == "Light" && !icon.rawValue.contains("Dark")) || (self.mode == "Dark" && icon.rawValue.contains("Dark")) {
                                /*
                                if UserDefaults.standard.bool(forKey: "pro") {
                                    Button(action: {
                                        if UIApplication.shared.supportsAlternateIcons {
                                            UIApplication.shared.setAlternateIconName("\(icon.rawValue)")
                                            self.activeIcon = icon.rawValue
                                        }
                                    }) {
                                        AppIconRow(icon: icon, activeIcon: self.activeIcon)
                                    }
                                } else {
                                    ZStack {
                                        AppIconRow(icon: icon, activeIcon: self.activeIcon)

                                        NavigationLink(destination:
                                            ProPreview()
                                                .environmentObject(SubscriptionManager.shared)
                                                .navigationBarTitle("Fluxura Pro")
                                        ) {
                                            EmptyView()
                                        }
                                    }
                                    AppIconRow(icon: icon, activeIcon: self.activeIcon)
                                }
                                */
                                
                                Button(action: {
                                    if UserDefaults.standard.bool(forKey: "pro") {
                                        if UIApplication.shared.supportsAlternateIcons {
                                            UIApplication.shared.setAlternateIconName("\(icon.rawValue)")
                                            self.activeIcon = icon.rawValue
                                        }
                                    } else {
                                        self.showPro = true
                                    }
                                }) {
                                    AppIconRow(icon: icon, activeIcon: self.activeIcon)
                                }
                            }
                        }
                    }
                }
            }
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(Text("App Icon"))
            
            NavigationLink(destination:
                ProPreview()
                    .environmentObject(SubscriptionManager.shared),
                           isActive: $showPro
            ) {
                EmptyView()
            }
        }
    }
}

struct AppIconsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
                AppIconsView()
                .environment(\.horizontalSizeClass, .regular)
        }
    }
}

struct AppIconRow: View {
    var icon: SettingsStore.AppIcon
    var activeIcon: String
    
    @State var showPreview = false
    @State var selectedIcon: SettingsStore.AppIcon = .twilight
    
    var body: some View {
        HStack {
            Button(action: {
                self.selectedIcon = self.icon
                self.showPreview = true
            }) {
                Image("\(icon.rawValue)")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 48, height: 48)
                    .cornerRadius(8)
                    .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 2, y: 2)
                    .padding([.vertical, .trailing], 8)
            }
            .buttonStyle(BorderlessButtonStyle())
            
            Text("\(icon.rawValue)")
                .font(.headline)
            
            Spacer()
            
            if self.activeIcon == icon.rawValue {
                Image(systemName: "checkmark")
                    .font(.headline)
                    .foregroundColor(
                        UserDefaults.standard.bool(forKey: "reduce_colors") ?
                            Color.primary :
                            Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                )
            }
            
            /*
             Image(systemName: "\(self.icon == icon.rawValue ? "checkmark." : "")circle\(self.icon == icon.rawValue ? ".fill" : "")")
             .imageScale(.large)
             .font(.headline)
             .foregroundColor(
             UserDefaults.standard.bool(forKey: "reduce_colors") ?
             Color.primary :
             Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
             )
             */
        }
        .onAppear {
            UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        }
        .foregroundColor(.primary)
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
                            .fill(Color(.systemIndigo)))
                }
                .padding(.horizontal)
            }
        }
    }
}
