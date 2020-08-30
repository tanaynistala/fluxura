//
//  TipJarView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 7/29/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import Purchases

struct TipJar: View {
    @EnvironmentObject private var subscriptionManager: SubscriptionManager
    @Environment(\.presentationMode) var presentationMode
    let titles = ["A generous tip", "A hefty tip", "A lavish tip"]
    
    private var smallTip: Purchases.Package? {
        subscriptionManager.smallTip
    }
    
    private var mediumTip: Purchases.Package? {
        subscriptionManager.mediumTip
    }
    
    private var largeTip: Purchases.Package? {
        subscriptionManager.largeTip
    }
    
    private func formattedPrice(for package: Purchases.Package) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = smallTip!.product.priceLocale
        return formatter.string(from: package.product.price)!
    }
    
    private func buttonAction(purchase: Purchases.Package) {
        subscriptionManager.purchase(product: purchase)
    }
    
    private func makePurchaseButton(action: @escaping () -> Void, title: String, index: Int, label:
            LocalizedStringKey) -> some View {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.headline)
                    HStack {
                        ForEach(0..<index) { item in
                            Image(systemName: "heart.fill")
                        }
                        ForEach(0..<3-index) { item in
                            Image(systemName: "heart")
                        }
                    }
                    .font(.headline)
                    .foregroundColor(Color(.systemRed))
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
                                        Color(.tertiarySystemGroupedBackground) :
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
                smallTip.map { smallTip in
                    makePurchaseButton(action: {
                        self.buttonAction(purchase: smallTip)
                    }, title: "A Generous Tip", index: 1, label: "\(formattedPrice(for: smallTip))")
                    .opacity(subscriptionManager.inPaymentProgress ? 0.5 : 1.0)
                    .disabled(subscriptionManager.inPaymentProgress)
                }
                
                mediumTip.map { mediumTip in
                    makePurchaseButton(action: {
                        self.buttonAction(purchase: mediumTip)
                    }, title: "A Hefty Tip", index: 2, label: "\(formattedPrice(for: mediumTip))")
                    .opacity(subscriptionManager.inPaymentProgress ? 0.5 : 1.0)
                    .disabled(subscriptionManager.inPaymentProgress)
                }
                
                largeTip.map { largeTip in
                    makePurchaseButton(action: {
                        self.buttonAction(purchase: largeTip)
                    }, title: "A Lavish Tip", index: 3, label: "\(formattedPrice(for: largeTip))")
                    .opacity(subscriptionManager.inPaymentProgress ? 0.5 : 1.0)
                    .disabled(subscriptionManager.inPaymentProgress)
                }
            }
        }
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("If you'd like to help support the app and us (the devs) even more, we'd greatly appreciate any extra tips!")
                Text("To be clear, these don't unlock any extra functionality.")
                    .foregroundColor(Color(.secondaryLabel))
                
                self.paymentButtons
                
                Spacer()
                
                /*
                Image("Heart Code \(colorScheme == .dark ? "Dark" : "Light")")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(16/9, contentMode: .fit)
                .scaleEffect(0.25)
                 */
            }
        }
        .padding()
        .navigationBarTitle("Tip Jar")
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TipJar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TipJar()
            .environmentObject(SubscriptionManager.shared)
        }
    }
}

struct TipButton: View {
    @Environment(\.colorScheme) var colorScheme
    var title: String = ""
    var amount: String = "0.0"
    var index: Int = 1
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                HStack {
                    ForEach(0..<index) { item in
                        Image(systemName: "heart.fill")
                    }
                    ForEach(0..<3-index) { item in
                        Image(systemName: "heart")
                    }
                }
                .font(.headline)
                .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .red)
            }
            Spacer()
            Button(action: {}) {
                Text("$\(amount)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(
                        Capsule()
                            .foregroundColor(
                                UserDefaults.standard.bool(forKey: "reduce_colors") ?
                                    Color(.tertiarySystemGroupedBackground) :
                                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                            )
                    )
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(16)
    }
}
