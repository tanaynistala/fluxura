//
//  SettingsView.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/17/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle(isOn: $settings.isHapticsEnabled) {
                        Image(systemName: "bolt.fill")
                            .imageScale(.large)
                        Text("App Haptics")
                    }
                    
                    Toggle(isOn: $settings.isKeyboardHapticsEnabled) {
                        Image(systemName: "keyboard")
                            .imageScale(.large)
                        Text("Keyboard Haptics")
                    }
                    
                    Toggle(isOn: $settings.editOnOpen) {
                        Image(systemName: "square.and.pencil")
                            .imageScale(.large)
                        Text("Edit on Open")
                    }
                    
                    Toggle(isOn: $settings.reduceMotion) {
                        Image(systemName: "wind")
                            .imageScale(.large)
                        Text("Reduce Motion")
                    }
                }

                Section(footer:
                    Text("To update the app theme, reload the app or tap on the active text field.")
                ) {
                    HStack {
                        Image(systemName: "circle.lefthalf.fill")
                            .imageScale(.large)
                        Text("Theme")
                        
                        Spacer(minLength: 32)
                        
                        Picker(
                            selection: $settings.appTheme,
                            label: HStack {
                                Image(systemName: "circle.lefthalf.fill")
                                Text("Theme")
                            }
                        ) {
                            Text("System").tag(0)
                            Text("Light").tag(1)
                            Text("Dark").tag(2)
                        }.pickerStyle(SegmentedPickerStyle())
                        .disabled(true)
                        .fixedSize(horizontal: true, vertical: true)
                    }
                    
                    Toggle(isOn: $settings.reduceColors) {
                        Image(systemName: "eyedropper.halffull")
                            .imageScale(.large)
                        Text("Reduce Colors")
                    }

                    Picker(
                        selection: $settings.appTint,
                        label: HStack {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                            Text("App Tint")
                        }
                    ) {
                        ForEach(SettingsStore.AppColor.allCases, id: \.self) {
                            ColorRow(color: $0.rawValue).tag($0)
                        }
                        .environment(\.horizontalSizeClass, .regular)
                        .navigationBarTitle("App Tint")
                    }
                    .navigationBarTitle("Settings")
                }

                if !settings.isPro {
                    Section {
                        Button(action: {
                            self.settings.unlockPro()
                        }) {
                            Text("Unlock Pro")
                        }

                        Button(action: {
                            self.settings.restorePurchase()
                        }) {
                            Text("Restore purchase")
                        }
                    }
                    .foregroundColor(.secondary)
                    .disabled(true)
                }
            }
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                }) {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .font(Font.system(size: 16).weight(.bold))
                        .frame(width: 32, height: 32)
                }
                .buttonStyle(IconButtonStyle())
                .foregroundColor(
//                UserDefaults.standard.bool(forKey: "reduce_colors") ?
//                Color.primary :
//                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "blue")
                    .primary
                )
            )
        }
        .accentColor(
            UserDefaults.standard.bool(forKey: "reduce_colors") ?
            Color.primary :
            Color(UserDefaults.standard.string(forKey: "app_tint") ?? "blue")
        )
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ColorRow: View {
    @State var color: String = ""
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundColor(Color("\(self.color)"))
            
            Text("\(self.color.capitalized)")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
        .environmentObject(SettingsStore())
    }
}
