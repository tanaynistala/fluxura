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
    @State var isProView = false
    @State var icon = UIApplication.shared.alternateIconName
    
    func refresh() {
        icon = UIApplication.shared.alternateIconName
    }
    
    /// Make the pickers Navigation Links to deal with Pro features
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: ProPreview()
                        .navigationBarTitle(Text("Fourier Pro"))
                        .environmentObject(self.settings),
                    isActive: self.$isProView
                ) {EmptyView()}
                
                Form {
                    if !settings.isPro {
                        Button(action: {
                            self.isProView.toggle()
                            if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                        }) {
                            HStack {
                                Image(systemName: "lock.fill")
                                    .font(Font.system(.title).weight(.semibold))
                                    .padding(4)
                                VStack(alignment: .leading) {
                                    Text("Fourier Pro")
                                        .font(.headline)

                                    Text("Unlock All Features")
                                        .font(.caption)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.white)
                            .padding(.bottom, 8)
                            .padding(.top, 192)
                            .listRowBackground(
                                Image("Fourier Pro")
                                    .resizable()
                                    .renderingMode(.original)
                                    .antialiased(true)
                                    .aspectRatio(2, contentMode: .fill)
                                    .padding(.bottom, 64)
                                    .background(Color(UserDefaults.standard.string(forKey: "app_tint") ?? "blue"))
                            )
                        }.buttonStyle(PlainButtonStyle())
                    }
                    
                    
                    Section(header: Text("GENERAL")) {
                        if UIDevice.current.model == "iPhone" {
                            Toggle(isOn: $settings.isHapticsEnabled) {
                                Image(systemName: "bolt.fill")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .yellow)
                                VStack(alignment: .leading) {
                                    Text("App Haptics")
                                    Text("Make your phone vibrate.")
                                        .font(.caption)
                                }
                            }
                            
                            Toggle(isOn: $settings.isKeyboardHapticsEnabled) {
                                Image(systemName: "keyboard")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .primary)
                                VStack(alignment: .leading) {
                                    Text("Keyboard Haptics")
                                    Text("Keypresses!")
                                        .font(.caption)
                                }
                            }
                        }
                        
                        Toggle(isOn: $settings.editOnOpen) {
                            Image(systemName: "pencil")
                                .imageScale(.large)
                                .frame(width: 32)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .primary)
                            VStack(alignment: .leading) {
                                Text("Edit on Open")
                                Text("Open the keyboard automagically.")
                                    .font(.caption)
                            }
                        }
                        
                        Toggle(isOn: $settings.reduceMotion) {
                            Image(systemName: "wind")
                                .imageScale(.large)
                                .frame(width: 32)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .gray)
                            VStack(alignment: .leading) {
                                Text("Reduce Motion")
                                Text("Make stuff move less.")
                                    .font(.caption)
                            }
                        }
                    }

                    Section(header: Text("APPEARANCE")) {
                        HStack {
                            Image(systemName: "circle.lefthalf.fill")
                                .imageScale(.large)
                                .frame(width: 32)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .primary)
                            Text("Theme")
                            
                            Spacer(minLength: 32)
                            
                            Picker(
                                selection: $settings.appTheme,
                                label: HStack {
                                    Image(systemName: "circle.lefthalf.fill")
                                        .imageScale(.large)
                                        .frame(width: 32)
                                    Text("Theme")
                                }
                            ) {
                                Text("System").tag(0)
                                Text("Light").tag(1)
                                Text("Dark").tag(2)
                            }.pickerStyle(SegmentedPickerStyle())
                            .disabled(true)
                        }
                        
                        Toggle(isOn: $settings.reduceColors) {
                            Image(systemName: "eyedropper.halffull")
                                .imageScale(.large)
                                .frame(width: 32)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .purple)
                            VStack(alignment: .leading) {
                                Text("Reduce Colors")
                                Text("Too much color?")
                                    .font(.caption)
                            }
                        }

                        if settings.isPro {
                            Picker(
                                selection: $settings.appTint,
                                label: HStack {
                                    Image(systemName: "paintbrush")
                                        .imageScale(.large)
                                        .frame(width: 32)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .red)
                                    VStack(alignment: .leading) {
                                        Text("App Tint")
                                        Text("Color the app.")
                                            .font(.caption)
                                    }
                                }
                            ) {
                                
                                ForEach(SettingsStore.AppColor.allCases, id: \.self) {
                                    ColorRow(color: $0.rawValue).tag($0)
                                }
                                .navigationBarTitle("App Tint")
                            }
                            .navigationBarTitle("Settings")
                        } else {
                            NavigationLink(destination:
                                ProPreview()
                                    .environmentObject(self.settings)
                                    .navigationBarTitle("Fourier Pro")
                            ) {
                                Image(systemName: "paintbrush")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .red)
                                VStack(alignment: .leading) {
                                    Text("App Tint")
                                    Text("Color the app.")
                                        .font(.caption)
                                }
                            }
                        }
                        
                        if settings.isPro {
                            NavigationLink(destination:
                                List {
                                    ForEach(SettingsStore.AppIcon.allCases, id: \.self) { icon in
                                        HStack {
                                            Image("\(icon.rawValue)")
                                                .resizable()
                                                .renderingMode(.original)
                                                .aspectRatio(1, contentMode: .fit)
                                                .frame(width: 48, height: 48)
                                                .cornerRadius(8)
                                                .padding([.vertical, .trailing], 8)
                                            
                                            VStack {
                                                Text("\(icon.rawValue)")
                                            }
                                            
                                            Spacer()
                                            
                                            if self.icon == icon.rawValue {
                                                Image(systemName: "checkmark")
                                                    .imageScale(.large)
                                                    .font(.headline)
                                            }
                                        }
                                        .onTapGesture {
                                            UIApplication.shared.setAlternateIconName("\(icon.rawValue)")
                                            self.refresh()
                                        }
                                    }
                                }
                                .navigationBarTitle(Text("App Icon"))
                                .environment(\.horizontalSizeClass, .regular)
                            ) {
                                Image(systemName: "app")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color(UIColor.systemTeal))
                                VStack(alignment: .leading) {
                                    Text("App Icon")
                                    Text("Change the app's icon.")
                                        .font(.caption)
                                }
                            }
                        } else {
                            NavigationLink(destination:
                                ProPreview()
                                    .environmentObject(self.settings)
                                    .navigationBarTitle("Fourier Pro")
                            ) {
                                Image(systemName: "app.gift")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color(UIColor.systemTeal))
                                VStack(alignment: .leading) {
                                    Text("App Icon")
                                    Text("Change the app's icon.")
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("REACH US")) {
                        NavigationLink(destination: EmptyView()) {
                            Image(systemName: "envelope")
                                .imageScale(.large)
                                .frame(width: 32)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .orange)
                            VStack(alignment: .leading) {
                                Text("Contact Us")
                                Text("Ask us anything, or request a feature.")
                                    .font(.caption)
                            }
                        }
                        
                        NavigationLink(destination: EmptyView()) {
                            Image(systemName: "text.bubble")
                                .imageScale(.large)
                                .frame(width: 32)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .blue)
                            VStack(alignment: .leading) {
                                Text("Tweet Us")
                                Text("Spread the word.")
                                    .font(.caption)
                            }
                        }
                        
                        NavigationLink(destination: EmptyView()) {
                            Image(systemName: "heart")
                                .imageScale(.large)
                                .frame(width: 32)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .pink)
                            VStack(alignment: .leading) {
                                Text("Leave a Review")
                                Text("Tell us what we're doing right (and wrong).")
                                    .font(.caption)
                            }
                        }
                        
                        NavigationLink(destination: EmptyView()) {
                            Image(systemName: "questionmark")
                                .imageScale(.large)
                                .frame(width: 32)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .gray)
                            VStack(alignment: .leading) {
                                Text("Help")
                                Text("Having trouble?")
                                    .font(.caption)
                            }
                        }
                    }
                    
                    Section(header: Text("LEGAL")) {
                        NavigationLink(destination: EmptyView()) {
                            Image(systemName: "lock.shield")
                                .imageScale(.large)
                                .frame(width: 32)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .green)
                            VStack(alignment: .leading) {
                                Text("Privacy Policy")
                                Text("TL;DR: We have nothing on you.")
                                    .font(.caption)
                            }
                        }
                        
                        NavigationLink(destination: EmptyView()) {
                            Image(systemName: "doc.text")
                                .imageScale(.large)
                                .frame(width: 32)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color(UIColor.systemIndigo))
                            VStack(alignment: .leading) {
                                Text("Terms of Use")
                                Text("It's simple.")
                                    .font(.caption)
                            }
                        }
                    }

                    if !settings.isPro {
                        Section {
                            Button(action: {
                                self.isProView.toggle()
                                self.settings.unlockPro()
                            }) {
                                Text("Unlock Fourier Pro")
                            }

                            Button(action: {
                                self.settings.restorePurchase()
                            }) {
                                Text("Restore Purchase")
                            }
                        }
    //                    .foregroundColor(.secondary)
    //                    .disabled(true)
                    }
                }
                .onAppear{
                    UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
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
