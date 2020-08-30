//
//  AppView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/17/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    @State var settingsShown = false

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ContentView()
                    .environmentObject(AppData.shared)
                    .environment(\.horizontalSizeClass, .regular)

                VStack {
                    Spacer()
                    
                    BottomSheetView(
                            isOpen: self.$data.keyboardShown,
                            maxHeight: self.data.keyboardView == 1 ? 372 : 312,
                            minHeight: self.data.presetsShown ? 0 : 92
                        ) {
                            KeyboardView()
                                .environmentObject(AppData.shared)
                        }
                        .frame(height: self.data.presetsShown ? 0 : (self.data.keyboardShown ? (self.data.keyboardView == 1 ? 372 : 312) : 92) )
                        .animation(self.reduceMotion || UserDefaults.standard.bool(forKey: "reduce_motion") ? nil : .easeInOut)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .sheet(isPresented: self.$data.onboarding) {
                        Splashscreen()
                            .environmentObject(AppData.shared)
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(AppData())
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()

        let standard = UINavigationBarAppearance()
        standard.largeTitleTextAttributes = [.foregroundColor: UIColor(named: SettingsStore.shared.appTint.rawValue) ?? UIColor.systemIndigo]

        navigationBar.standardAppearance = standard
    }
}
