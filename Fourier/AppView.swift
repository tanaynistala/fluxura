//
//  AppView.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/17/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import Combine

struct AppView: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    @State var settingsShown = false
    @State private var keyboardShown = UserDefaults.standard.bool(forKey: "edit_on_open")
    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
        VStack(spacing: 0) {
            ContentView()
                .environmentObject(self.data)
                
            KeyboardAccessoryView()
                .environmentObject(self.data)
                .animation(.spring())
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear{UserDefaults.standard.set(false, forKey: "pro")}
        .padding(.bottom, self.keyboardHeight)
        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(AppData())
//            .environment(\.colorScheme, .dark)
    }
}
