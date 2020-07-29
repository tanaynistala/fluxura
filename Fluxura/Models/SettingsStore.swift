//
//  SettingsStore.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/17/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

final class SettingsStore: ObservableObject {
    private enum Keys {
        static let pro = "pro"
        static let hapticsEnabled = "haptics_enabled"
        static let keyboardHapticsEnabled = "keyboard_haptics_enabled"
        static let reduceColors = "reduce_colors"
        static let appTint = "app_tint"
        static let appTheme = "app_theme"
        static let editOnOpen = "edit_on_open"
        static let reduceMotion = "reduce_motion"
        static let appIcon = "app_icon"
        static let nativeKeyboard = "native_keyboard"
        static let largeText = "large_text"
        static let angleType = "angle_type"
        static let precisionType = "precision_type"
        static let precision = "precision"
        static let showMenu = "show_menu"
    }

    private let cancellable: Cancellable
    private let defaults: UserDefaults

    let objectWillChange = PassthroughSubject<Void, Never>()

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        defaults.register(defaults: [
            Keys.hapticsEnabled: true,
            Keys.keyboardHapticsEnabled: true,
            Keys.reduceColors: false,
            Keys.appTint: AppColor.indigo.rawValue,
            Keys.appTheme: 0,
            Keys.editOnOpen: true,
            Keys.reduceMotion: false,
            Keys.appIcon: "Sine Light",
            Keys.nativeKeyboard: false,
            Keys.largeText: false,
            Keys.angleType: 1,
            Keys.precisionType: false,
            Keys.precision: 3,
            Keys.showMenu: false
        ])

        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .subscribe(objectWillChange)
    }

    var isHapticsEnabled: Bool {
        set { defaults.set(newValue, forKey: Keys.hapticsEnabled) }
        get { defaults.bool(forKey: Keys.hapticsEnabled) }
    }
    
    var isKeyboardHapticsEnabled: Bool {
        set { defaults.set(newValue, forKey: Keys.keyboardHapticsEnabled) }
        get { defaults.bool(forKey: Keys.keyboardHapticsEnabled) }
    }
    
    var appTheme: Int {
        set { defaults.set(newValue, forKey: Keys.appTheme) }
        get { defaults.integer(forKey: Keys.appTheme) }
    }
    
    var editOnOpen: Bool {
        set { defaults.set(newValue, forKey: Keys.editOnOpen) }
        get { defaults.bool(forKey: Keys.editOnOpen) }
    }
    
    var largeText: Bool {
        set { defaults.set(newValue, forKey: Keys.largeText) }
        get { defaults.bool(forKey: Keys.largeText) }
    }
    
    var reduceMotion: Bool {
        set { defaults.set(newValue, forKey: Keys.reduceMotion) }
        get { defaults.bool(forKey: Keys.reduceMotion) }
    }
    
    var reduceColors: Bool {
        set { defaults.set(newValue, forKey: Keys.reduceColors) }
        get { defaults.bool(forKey: Keys.reduceColors) }
    }

    var isPro: Bool {
        set { defaults.set(newValue, forKey: Keys.pro) }
        get { defaults.bool(forKey: Keys.pro) }
    }
    
    var nativeKeyboard: Bool {
        set { defaults.set(newValue, forKey: Keys.nativeKeyboard) }
        get { defaults.bool(forKey: Keys.nativeKeyboard) }
    }

    enum AppColor: String, CaseIterable {
        case purple
        case indigo
        case blue
        case teal
        case green
        case yellow
        case orange
        case red
        case pink
        case gray
    }

    var appTint: AppColor {
        get {
            return defaults.string(forKey: Keys.appTint)
                .flatMap { AppColor(rawValue: $0) } ?? .indigo
        }

        set {
            defaults.set(newValue.rawValue, forKey: Keys.appTint)
            UISwitch.appearance().onTintColor = UIColor(named: "\(defaults.string(forKey: Keys.appTint) ?? "indigo")")
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.largeTitleTextAttributes = [.foregroundColor: defaults.bool(forKey: Keys.reduceColors) ? UIColor.systemGray : UIColor(named: defaults.string(forKey: Keys.appTint) ?? "indigo") ?? UIColor.systemIndigo]
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    enum AppIcon: String, CaseIterable {
        case SineLight = "Sine Light"
        case SineDark = "Sine Dark"
        case LogLight = "Log Light"
        case LogDark = "Log Dark"
        case TwilightMonochrome = "Twilight Monochrome"
        case SunriseMonochrome = "Sunrise Monochrome"
        case Twilight
        case Sunrise
        case NetworkLight = "Network Light"
        case NetworkDark = "Network Dark"
    }

    var appIcon: AppIcon {
        get {
            return defaults.string(forKey: Keys.appIcon)
            .flatMap { AppIcon(rawValue: $0) } ?? .SineLight
        }

        set {
            defaults.set(newValue.rawValue, forKey: Keys.appIcon)
        }
    }
}

extension SettingsStore {
    func unlockPro() {
        // You can do your in-app transactions here
        isPro = true
    }

    func restorePurchase() {
        // You can do you in-app purchase restore here
        isPro = true
    }
}