//
//  SubscriptionManager.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/4/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation
import SwiftUI
import Purchases

public class SubscriptionManager: ObservableObject {
    public static let shared = SubscriptionManager()
    
    @Published public var monthlySubscription: Purchases.Package?
    @Published public var yearlySubscription: Purchases.Package?
    @Published public var lifetime: Purchases.Package?
    
    @Published public var smallTip: Purchases.Package?
    @Published public var mediumTip: Purchases.Package?
    @Published public var largeTip: Purchases.Package?
    
    @Published public var inPaymentProgress = false
    @Published public var subscriptionStatus: Bool = UserDefaults.standard.bool(forKey: "pro")
    
    init() {
        Purchases.debugLogsEnabled = true
        Purchases.configure(withAPIKey: "kTYeywoFrpPYdplwWdVgtvJWpqHJJCdO")
        Purchases.shared.offerings { (offerings, error) in
            self.monthlySubscription = offerings?.current?.monthly
            self.lifetime = offerings?.current?.lifetime
            self.yearlySubscription = offerings?.current?.annual
            
            self.smallTip = offerings?.current?.package(identifier: "Small Tip")
            self.mediumTip = offerings?.current?.package(identifier: "Medium Tip")
            self.largeTip = offerings?.current?.package(identifier: "Large Tip")
        }
        refreshSubscription()
    }
    
    public func purchase(product: Purchases.Package) {
        guard !inPaymentProgress else { return }
        inPaymentProgress = true
        Purchases.shared.purchasePackage(product) { (_, info, _, _) in
            self.processInfo(info: info)
        }
    }
    
    public func refreshSubscription() {
        Purchases.shared.purchaserInfo { (info, _) in
            self.processInfo(info: info)
        }
    }
    
    public func restorePurchase() {
        Purchases.shared.restoreTransactions { (info, _) in
            self.processInfo(info: info)
        }
    }
    
    private func processInfo(info: Purchases.PurchaserInfo?) {
        if info?.entitlements.all["fluxura_pro"]?.isActive == true {
            subscriptionStatus = true
            UserDefaults.standard.set(true, forKey: "pro")
        } else {
            if info?.entitlements.all["tip_jar"]?.isActive != true {
                UserDefaults.standard.set(false, forKey: "pro")
                subscriptionStatus = false
            }
        }
        inPaymentProgress = false
    }
}
