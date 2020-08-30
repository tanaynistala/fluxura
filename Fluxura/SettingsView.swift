//
//  SettingsView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/17/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import MessageUI
import StoreKit

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var data: AppData
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State var isProView = false
    @State var isEmailShown = false
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var bugResult: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var isShowingBugMailView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: ProPreview()
                        .environmentObject(SubscriptionManager.shared),
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
                            VStack {
                                Image("Fluxura Pro")
                                .resizable()
                                .renderingMode(.original)
                                .antialiased(true)
                                .aspectRatio(2, contentMode: .fill)
                                
                                HStack {
                                    Image(systemName: "lock.fill")
                                        .font(Font.system(.title).weight(.semibold))
                                        .padding(4)
                                    VStack(alignment: .leading) {
                                        Text("Fluxura Pro")
                                            .font(.headline)

                                        Text("Unlock All Features")
                                            .font(.caption)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.headline)
                                }
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal)
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        .listRowBackground(Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo"))
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Section(header: Text("MATH")) {
                        /*
                        Toggle(isOn: self.$data.showMenu) {
                            Image(systemName: "slider.horizontal.below.rectangle")
                                .imageScale(.large)
                                .frame(width: 32)
                                .font(.headline)
                                .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .purple)
                            VStack(alignment: .leading) {
                                Text("Display on Main Screen")
                                Text("Access this menu quickly.")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                          */
                        
                        HStack {
                            Image(systemName: "lessthan")
                                .imageScale(.large)
                                .frame(width: 32)
                                .font(.headline)
                                .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color(.systemTeal))
                                .rotationEffect(.degrees(self.data.angleType == 1 ? 0 : 180))
                                .animation(self.reduceMotion || UserDefaults.standard.bool(forKey: "reduce_motion") ? nil : .spring())
                            VStack(alignment: .leading) {
                                Text("Angles")
                                Text("Sorry, no gradians.")
                                    .font(.caption)
                            }
                            Spacer()
                            Picker(selection: self.$data.angleType, label: Text("Angles")) {
                                Text("Degrees").tag(1)
                                Text("Radians").tag(2)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .fixedSize(horizontal: true, vertical: true)
                            .animation(nil)
                        }
                        .padding(.vertical, 4)
                        
                        Toggle(isOn: self.$data.useSigFigs) {
                            Image(systemName: "number")
                                .imageScale(.large)
                                .frame(width: 32)
                                .font(.headline)
                                .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .red)
                            VStack(alignment: .leading) {
                                Text("Use Significant Digits")
                                Text("Turn off to use decimals.")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                    
                        Stepper(value: self.$data.precision, in: 0...10, onEditingChanged: {_ in
                            if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                                UISelectionFeedbackGenerator().selectionChanged()
                            }
                        }) {
                            HStack {
                                Image(systemName: "\(self.data.precision).square")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                    .foregroundColor(.primary)
                                VStack(alignment: .leading) {
                                    Text("\(self.data.useSigFigs ? "Significant Digit" : "Decimal Point")\(self.data.precision == 1 ? "" : "s")")
                                    Text("How precise?")
                                        .font(.caption)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowInsets(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 16))
                    
                    Section(header: Text("GENERAL")) {
                        if UIDevice.current.model == "iPhone" {
                            Toggle(isOn: $settings.isHapticsEnabled) {
                                Image(systemName: "bolt\(settings.isHapticsEnabled ? "" : ".slash").fill")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .yellow)
                                VStack(alignment: .leading) {
                                    Text("App Haptics")
                                    Text("Make your phone vibrate.")
                                        .font(.caption)
                                }
                            }
                            .padding(.vertical, 4)
                            
                            Toggle(isOn: $settings.isKeyboardHapticsEnabled) {
                                Image(systemName: "keyboard")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .font(.headline)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                    .foregroundColor(.primary)
                                VStack(alignment: .leading) {
                                    Text("Keyboard Haptics")
                                    Text("Keypresses!")
                                        .font(.caption)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        
                        /*
                        Toggle(isOn: $settings.nativeKeyboard) {
                            Image(systemName: "keyboard")
                                .imageScale(.large)
                                .frame(width: 32)
                                .font(.headline)
                                .padding(.horizontal, 4)
                                .foregroundColor(.primary)
                            VStack(alignment: .leading) {
                                Text("Use Native Keyboard")
                                Text("Use the system keyboard.")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                        */
                        
                        Toggle(isOn: $settings.editOnOpen) {
                            Image(systemName: "pencil\(settings.editOnOpen ? "" : ".slash")")
                                .imageScale(.large)
                                .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .orange)
                            VStack(alignment: .leading) {
                                Text("Edit on Open")
                                Text("Keep it ready for you on launch.")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                        
                        Toggle(isOn: $settings.autoOpenKeyboard) {
                            Image(systemName: "wand.and.stars")
                                .imageScale(.large)
                                .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .purple)
                            VStack(alignment: .leading) {
                                Text("Edit on Select")
                                Text("Automagically open the keyboard!")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                        
                        Toggle(isOn: $settings.reduceMotion) {
                            Image(systemName: "wind")
                                .imageScale(.large)
                                .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .gray)
                            VStack(alignment: .leading) {
                                Text("Reduce Motion")
                                Text("Make stuff move less.")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowInsets(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 16))

                    Section(header: Text("APPEARANCE")) {
                        Toggle(isOn: $settings.reduceColors) {
                            Image(systemName: "eyedropper.halffull")
                                .imageScale(.large)
                                .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .purple)
                            VStack(alignment: .leading) {
                                Text("Reduce Colors")
                                Text("Too much color?")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                        
                        NavigationLink(destination:
                            AppTintsView()
                                .environmentObject(SettingsStore.shared)
                        ) {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                                .frame(width: 32)
                                .font(.headline)
                                .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .red)
                            VStack(alignment: .leading) {
                                Text("App Tint")
                                Text("Color the app.")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                        
                        NavigationLink(destination:
                            AppIconsView()
                        ) {
                            Image(systemName: "app.gift")
                                .imageScale(.large)
                                .frame(width: 32)
                                .font(.headline)
                                .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color(.systemTeal))
                            VStack(alignment: .leading) {
                                Text("App Icon")
                                Text("Change the app's icon.")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)

                        /*
                        if settings.isPro {
                            Picker(
                                selection: $settings.appTint,
                                label: HStack {
                                    Image(systemName: "paintbrush")
                                        .imageScale(.large)
                                        .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
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
                            .padding(.vertical, 4)
                        } else {
                            NavigationLink(destination:
                                ProPreview()
                                    .environmentObject(SubscriptionManager.shared)
                                    .navigationBarTitle("Fluxura Pro")
                            ) {
                                Image(systemName: "paintbrush")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .red)
                                VStack(alignment: .leading) {
                                    Text("App Tint")
                                    Text("Color the app.")
                                        .font(.caption)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        
                        if settings.isPro {
                            NavigationLink(destination:
                                AppIconsView().environment(\.horizontalSizeClass, .regular)
                            ) {
                                Image(systemName: "app")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color(.systemTeal))
                                VStack(alignment: .leading) {
                                    Text("App Icon")
                                    Text("Change the app's icon.")
                                        .font(.caption)
                                }
                            }
                            .padding(.vertical, 4)
                        } else {
                            NavigationLink(destination:
                                ProPreview()
                                    .environmentObject(SubscriptionManager.shared)
                                    .navigationBarTitle("Fluxura Pro")
                            ) {
                                Image(systemName: "app.gift")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color(.systemTeal))
                                VStack(alignment: .leading) {
                                    Text("App Icon")
                                    Text("Change the app's icon.")
                                        .font(.caption)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                         */
                        
                        Toggle(isOn: $settings.largeText) {
                            Image(systemName: "textformat.size")
                                .imageScale(.large)
                                .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .green)
                            VStack(alignment: .leading) {
                                Text("Use Large Text")
                                Text("Use a larger font.")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowInsets(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 16))
                    
                    Section(header: Text("REACH OUT")) {
                        Button(action: {
                            self.isShowingMailView.toggle()
                        }) {
                            HStack {
                                Image(systemName: "envelope")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .orange)
                                VStack(alignment: .leading) {
                                    Text("Contact Us")
                                    Text("Get help or ask us anything.")
                                        .font(.caption)
                                }
                                Spacer()
                                Image(systemName: "arrow.up.right.circle.fill")
                                .foregroundColor(Color(.secondaryLabel))
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .disabled(!MFMailComposeViewController.canSendMail())
                        .sheet(isPresented: $isShowingMailView) {
                            MailView(result: self.$result, message: "")
                        }
                        
                        Button(action: {
                            self.isShowingBugMailView.toggle()
                        }) {
                            HStack {
                                Image(systemName: "ant")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .red)
                                VStack(alignment: .leading) {
                                    Text("Report a Bug")
                                    Text("Found an issue? Let us know!")
                                        .font(.caption)
                                }
                                Spacer()
                                Image(systemName: "arrow.up.right.circle.fill")
                                .foregroundColor(Color(.secondaryLabel))
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .disabled(!MFMailComposeViewController.canSendMail())
                        .sheet(isPresented: $isShowingBugMailView) {
                            MailView(
                                result: self.$bugResult,
                                message: "Device Info:\nOS Version: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)\nDevice Model: \(UIDevice.current.localizedModel)(\(UIDevice.current.name))\nApp Version: \(UIApplication.appVersion ?? "") (\(UIApplication.buildNumber ?? "1"))\n\nFeedback:"
                            )
                        }
                        
                        Button(action: {
                            UIApplication.shared.open(URL(string: "https://twitter.com/timswagwalker")!)
                        }) {
                            HStack {
                                Image(systemName: "text.bubble")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .font(.headline)
                                        .padding(.horizontal, 4)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color("indigo"))
                                VStack(alignment: .leading) {
                                    Text("Tweet Us")
                                    Text("Spread the word.")
                                        .font(.caption)
                                }
                                Spacer()
                                Image(systemName: "arrow.up.right.circle.fill")
                                .foregroundColor(Color(.secondaryLabel))
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            SKStoreReviewController.requestReview()
                        }) {
                            HStack {
                                Image(systemName: "heart")
                                    .imageScale(.large)
                                    .frame(width: 32)
                                    .font(.headline)
                                        .padding(.horizontal, 4)
                                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .pink)
                                VStack(alignment: .leading) {
                                    Text("Leave a Review")
                                    Text("Tell us what we're doing right (and wrong).")
                                        .font(.caption)
                                }
                                Spacer()
                                Image(systemName: "arrow.up.right.circle.fill")
                                .foregroundColor(Color(.secondaryLabel))
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.vertical, 4)
                        
                        NavigationLink(destination: Help()) {
                            Image(systemName: "questionmark")
                                .imageScale(.large)
                                .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .gray)
                            VStack(alignment: .leading) {
                                Text("Help")
                                Text("Having trouble?")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                        
                        NavigationLink(destination: TipJar().environmentObject(SubscriptionManager.shared)) {
                            Image(systemName: "gift")
                                .imageScale(.large)
                                .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .blue)
                            VStack(alignment: .leading) {
                                Text("Tip Jar")
                                Text("Support the devs.")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowInsets(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 16))
                    
                    Section(header: Text("LEGAL")) {
                        NavigationLink(destination: PrivacyPolicy()) {
                            Image(systemName: "lock.shield")
                                .imageScale(.large)
                                .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .green)
                            VStack(alignment: .leading) {
                                Text("Privacy Policy")
                                Text("TL;DR: We have nothing on you.")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                        
                        NavigationLink(destination: TermsOfUse()) {
                            Image(systemName: "doc.text")
                                .imageScale(.large)
                                .frame(width: 32)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : Color(.systemIndigo))
                            VStack(alignment: .leading) {
                                Text("Terms of Use")
                                Text("It's simple.")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowInsets(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 16))
                    
                    Section {
                        VStack {
                            Image(UIApplication.shared.alternateIconName ?? "Twilight")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(width: 64, height: 64, alignment: .center)
                                .cornerRadius(16)
                                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.05), radius: 4, y: 2)
                            
                            HStack {
                                Spacer()
                                VStack {
                                    Text("Fluxura\(self.settings.isPro ? " Pro" : "")")
                                    Text("\(UIApplication.appVersion ?? "") (\(UIApplication.buildNumber ?? "1"))")
                                        .foregroundColor(Color(.placeholderText))
                                }
                                .font(.headline)
                                Spacer()
                            }
                        }
                        .padding(.vertical, 32)
                        .listRowBackground(Color(.systemGroupedBackground))
                    }
                }
                .onAppear {
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
                            .font(Font.system(size: 16).weight(.medium))
                            .frame(width: 24, height: 24)
                    }
                    .buttonStyle(IconButtonStyle())
                    .foregroundColor(.primary)
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
        .environmentObject(SettingsStore.shared)
        .environmentObject(AppData.shared)
    }
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    static var buildNumber: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
