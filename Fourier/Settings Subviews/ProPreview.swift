//
//  ProPreview.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/21/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct ProPreview: View {
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("What you'll get:")
                    .font(.headline)
                
                ProFeatureDetail(title: "Non-Linear Equations", subTitle: "Unlock the ability to solve non-linear differential equations in no time!", imageName: "slash.circle.fill", color: .green)
                
                ProFeatureDetail(title: "Equation Presets", subTitle: "Get presets for common differential equations in physics, biology, chemistry, and computer science.", imageName: "tuningfork", color: .gray)
                
                ProFeatureDetail(title: "App Tints", subTitle: "Color the app the way you like it. We've got purple and green and red, and everything in between.", imageName: "paintbrush.fill", color: .purple)
                
                ProFeatureDetail(title: "App Icons", subTitle: "Pick the app icon that suits you. We've always got more coming too!", imageName: "app.fill", color: .orange)
                
                ProFeatureDetail(title: "Support Us", subTitle: "Support the devs and help us get out new features for Fourier!", imageName: "heart.fill", color: .pink)

                HStack(spacing: 16) {
                    Button(action: {self.settings.unlockPro()}) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Monthly")
                                    .font(Font.system(.title).weight(.semibold))
                                Text("$1.99/mo")
                                    .font(.headline)
                            }
                            .foregroundColor(
                                UserDefaults.standard.bool(forKey: "reduce_colors") ?
                                Color.primary :
                                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                            )
                            .padding()
                            Spacer()
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(UserDefaults.standard.bool(forKey: "reduce_colors") ?
                                Color.primary :
                                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo"), lineWidth: 3)
                        )
                    }.buttonStyle(PlainButtonStyle())
                    
                    Button(action: {self.settings.unlockPro()}) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Yearly")
                                    .font(Font.system(.title).weight(.semibold))
                                Text("$19.99/yr")
                                    .font(.headline)
                            }
                            Spacer()
                            Image(systemName: "star.fill")
                                .imageScale(.large)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 4)
                        .background(UserDefaults.standard.bool(forKey: "reduce_colors") ?
                        Color.primary :
                        Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo"))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }.buttonStyle(PlainButtonStyle())
                }.padding(.vertical)
                
                Button(action: {self.settings.unlockPro()}) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Lifetime")
                                .font(Font.system(.title).weight(.semibold))
                            Text("$39.99")
                                .font(.headline)
                        }
                        .foregroundColor(
                            UserDefaults.standard.bool(forKey: "reduce_colors") ?
                            Color.primary :
                            Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                        )
                        .padding()
                        Spacer()
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(UserDefaults.standard.bool(forKey: "reduce_colors") ?
                            Color.primary :
                            Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo"), lineWidth: 3)
                    )
                }.buttonStyle(PlainButtonStyle())

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
    }
}

struct ProFeatureDetail: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"
    var color: Color = .red

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(color)
                .padding()
                .accessibility(hidden: true)
                .frame(width: 64)

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

struct PurchaseView: View {
    @State var title: String = "Time"
    @State var price: String = "$..."
    @State var color: Color = .red
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(Font.system(.title).weight(.semibold))
                Text(price)
                    .font(.headline)
            }
            .foregroundColor(.white)
            .padding()
            Spacer()
            
            if title == "Yearly" {
                Image(systemName: "star.fill")
                    .imageScale(.large)
                    .foregroundColor(.yellow)
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 10)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 5, y: 2)
        .padding(.vertical, 8)
    }
}
