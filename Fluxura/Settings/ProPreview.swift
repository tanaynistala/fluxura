//
//  ProPreview.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/21/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import Purchases

struct ProPreview: View {
    @EnvironmentObject private var subscriptionManager: SubscriptionManager
    @Environment(\.presentationMode) var presentationMode
    
//    private var sub: Purchases.Package? {
//        subscriptionManager.monthlySubscription
//    }
//    
//    private var yearlySub: Purchases.Package? {
//        subscriptionManager.yearlySubscription
//    }
    
    private var lifetime: Purchases.Package? {
        subscriptionManager.lifetime
    }
    
    private func formattedPrice(for package: Purchases.Package) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = lifetime!.product.priceLocale
        return formatter.string(from: package.product.price)!
    }
    
    private func buttonAction(purchase: Purchases.Package) {
        if subscriptionManager.subscriptionStatus == true {
            presentationMode.wrappedValue.dismiss()
        } else {
            subscriptionManager.purchase(product: purchase)
        }
    }
    
    private func makePurchaseButton(action: @escaping () -> Void, title: String, subtitle: String, label:
        LocalizedStringKey) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                if subtitle != "" {
                    Text(subtitle)
                        .font(.caption)
                }
            }
            Spacer()
            Button(action: action) {
                Text(label)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(
                        Capsule()
                            .foregroundColor(
                                UserDefaults.standard.bool(forKey: "reduce_colors") ?
                                    Color(.systemGray4) :
                                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                            )
                    )
            }
        }
        .padding()
        .background(Color(.tertiarySystemGroupedBackground))
        .cornerRadius(10)
    }
    
    private var paymentButtons: some View {
        VStack(spacing: 16) {
            /*
            sub.map { sub in
                makePurchaseButton(action: {
                    self.buttonAction(purchase: sub)
                }, title: "Monthly", subtitle: "Get 1 week free", label: "\(formattedPrice(for: sub))/mo")
                .opacity(subscriptionManager.inPaymentProgress ? 0.5 : 1.0)
                .disabled(subscriptionManager.inPaymentProgress)
            }
             */
            
            /*
            yearlySub.map { yearlySub in
                makePurchaseButton(action: {
                    self.buttonAction(purchase: yearlySub)
                }, title: "Yearly", subtitle: "Get 1 month free", label: "\(formattedPrice(for: yearlySub))/yr")
                .opacity(subscriptionManager.inPaymentProgress ? 0.5 : 1.0)
                .disabled(subscriptionManager.inPaymentProgress)
            }
             */
            
            lifetime.map { lifetime in
                makePurchaseButton(action: {
                    self.buttonAction(purchase: lifetime)
                }, title: "Fluxura Pro", subtitle: "", label: "\(formattedPrice(for: lifetime))")
                .opacity(subscriptionManager.inPaymentProgress ? 0.5 : 1.0)
                .disabled(subscriptionManager.inPaymentProgress)
            }
        }.padding()
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Text("What you'll get:")
                        .font(.headline)
                    
                    ProFeatureDetail(
                        title: "Non-Linear Equations",
                        subTitle: "Unlock the ability to solve non-linear differential equations in no time!",
                        imageName: "slash.circle.fill",
                        color: .green,
                        isComing: true
                    )
                    
                    ProFeatureDetail(
                        title: "Equation Presets",
                        subTitle: "Get presets for common differential equations in physics, biology, chemistry, and economics. We're always adding more!",
                        imageName: "square.stack.3d.up.fill",
                        color: .blue,
                        isComing: false
                    )
                    
                    ProFeatureDetail(
                        title: "App Tints",
                        subTitle: "Color the app the way you like it. We've got purple and green and red, and everything in between.",
                        imageName: "paintbrush.fill",
                        color: .purple,
                        isComing: false
                    )
                    
                    ProFeatureDetail(
                        title: "App Icons",
                        subTitle: "Pick the app icon that suits you. We've always got more coming too!",
                        imageName: "app.fill",
                        color: .orange,
                        isComing: false
                    )
                    
                    ProFeatureDetail(title: "Support Us", subTitle: "Support the devs and help us continue developing Fluxura!", imageName: "heart.fill", color: .pink)
                }.padding()
            
                Divider()
                
                self.paymentButtons
                
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
                    
                    Button(action: {
                        self.subscriptionManager.restorePurchase()
                    }) {
                        Text("Restore Purchases")
                            .underline()
                    }
                    .opacity(subscriptionManager.inPaymentProgress ? 0.5 : 1.0)
                    .disabled(subscriptionManager.inPaymentProgress)
                    
                    NavigationLink(destination: TipJar().environmentObject(SubscriptionManager.shared)) {
                        Image(systemName: "archivebox")
                        Text("Tip Jar")
                    }
                    .padding(.vertical)
                }
                .foregroundColor(.secondary)
                .padding()
            }
        }
        .navigationBarTitle(Text("Fluxura Pro"))
    }
}

struct ProPreview_Previews: PreviewProvider {
    static var previews: some View {
        ProPreview()
            .environmentObject(SettingsStore.shared)
            .environmentObject(SubscriptionManager())
    }
}

struct ProFeatureDetail: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"
    var color: Color = .red
    var isComing: Bool = false

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: imageName)
                .padding([.horizontal, .bottom])
                .font(.largeTitle)
                .foregroundColor(color)
                .accessibility(hidden: true)
                .frame(width: 64, height: 64)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)
                
                if isComing {
                    Text("Coming Soon")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(4)
                        .foregroundColor(
                            UserDefaults.standard.bool(forKey: "reduce_colors") ?
                            Color.gray :
                            Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                        )
                        .background(
                            UserDefaults.standard.bool(forKey: "reduce_colors") ?
                                Color.gray.opacity(0.2) :
                                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo").opacity(0.2)
                        )
                        .cornerRadius(4)
                        .padding(.vertical, 8)
                }

                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 8)
    }
}
