//
//  AppTintsView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/22/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct AppTintsView: View {
    @EnvironmentObject var settings: SettingsStore
    @State var selectedIcon: SettingsStore.AppIcon = .twilight
    @State private var showPro: Bool = false
    
    var body: some View {
        ZStack {
            Form {
                Section {
                    ForEach(SettingsStore.AppColor.allCases, id: \.self) { tint in
                        Group {
                            Button(action: {
                                if UserDefaults.standard.bool(forKey: "pro") {
                                    self.settings.appTint = tint
                                } else {
                                    self.showPro = true
                                }
                            }) {
                                ColorRow(tint: tint)
                                    .environmentObject(SettingsStore.shared)
                            }
                        }
                    }
                }
            }
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(Text("App Tint"))
            
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

struct AppTintsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AppTintsView()
            .environmentObject(SettingsStore.shared)
        }
    }
}

struct ColorRow: View {
    @EnvironmentObject var settings: SettingsStore
    var tint: SettingsStore.AppColor
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundColor(Color("\(self.tint.rawValue)"))
                .padding(.trailing)
            
            Text("\(self.tint.rawValue.capitalized)")
            
            Spacer()
            
            if self.settings.appTint == tint {
                Image(systemName: "checkmark")
                    .font(.headline)
                    .foregroundColor(
                        UserDefaults.standard.bool(forKey: "reduce_colors") ?
                        Color.primary :
                        Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                    )
            }
        }
        .foregroundColor(.primary)
        .padding(.vertical, 8)
    }
}
