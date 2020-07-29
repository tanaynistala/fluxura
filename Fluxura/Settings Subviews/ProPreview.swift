//
//  ProPreview.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/21/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct ProPreview: View {
    @EnvironmentObject var settings: SettingsStore
    var titles = ["Monthly", "Yearly", "Lifetime"]
    var amounts = ["1.99/mo", "19.99/yr", "39.99"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("What you'll get:")
                    .font(.headline)
                
                ProFeatureDetail(title: "Non-Linear Equations", subTitle: "Unlock the ability to solve non-linear differential equations in no time!", imageName: "slash.circle.fill", color: .green)
                
                ProFeatureDetail(title: "Equation Presets", subTitle: "Get presets for common differential equations in physics, biology, chemistry, and computer science.", imageName: "square.stack.3d.up.fill", color: .blue)
                
                ProFeatureDetail(title: "App Tints", subTitle: "Color the app the way you like it. We've got purple and green and red, and everything in between.", imageName: "paintbrush.fill", color: .purple)
                
                ProFeatureDetail(title: "App Icons", subTitle: "Pick the app icon that suits you. We've always got more coming too!", imageName: "app.fill", color: .orange)
                
                ProFeatureDetail(title: "Support Us", subTitle: "Support the devs and help us create new features for Fluxura!", imageName: "heart.fill", color: .pink)
            }.padding()
            
            Divider()
            
            VStack(spacing: 16) {
                ForEach(0..<3) { index in
                    PurchaseButton(title: self.titles[index], amount: self.amounts[index])
                        .environmentObject(self.settings)
                }
            }.padding()
            
            VStack {
                HStack {
                    NavigationLink(destination: PrivacyPolicy()) {
                        Text("Privacy Policy")
                            .underline()
                    }
                    Divider()
                    NavigationLink(destination: TermsOfUse()) {
                        Text("Terms of Use")
                            .underline()
                    }
                }
                
                Button(action: {self.settings.restorePurchase()}) {
                    Text("Restore Purchases")
                        .underline()
                }
            }
            .foregroundColor(.secondary)
            .padding()
        }
    }
}

struct ProPreview_Previews: PreviewProvider {
    static var previews: some View {
        ProPreview()
        .environmentObject(SettingsStore())
    }
}

struct ProFeatureDetail: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"
    var color: Color = .red

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: imageName)
                .padding([.horizontal, .bottom])
//                .padding(.top, 12)
                .font(.largeTitle)
                .foregroundColor(color)
                .accessibility(hidden: true)
                .frame(width: 64, height: 64)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)

                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 8)
    }
}

struct PurchaseButton: View {
    @Environment(\.colorScheme) var colorScheme
    @State var title: String = "Time"
    @State var amount: String = "0.0"
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
            }
            Spacer()
            Button(action: {self.settings.unlockPro()}) {
                Text("$\(amount)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(
                        Capsule()
                            .foregroundColor(
                                UserDefaults.standard.bool(forKey: "reduce_colors") ?
                                Color.primary :
                                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                            )
                    )
            }
        }
        .padding()
        .background(Color(colorScheme == .dark ? .systemGray5 : .white))
        .cornerRadius(16)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 8, y: 2)
    }
}
