//
//  AppView.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/17/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    @State var settingsShown = false
    @State private var keyboardShown = UserDefaults.standard.bool(forKey: "edit_on_open")

    var body: some View {
        VStack {
            GeometryReader { geometry in
//                VStack(spacing: 0) {
//                    ContentView()
//                        .environmentObject(self.data)
//
//                    BottomSheetView(
//                        isOpen: self.$keyboardShown,
//                        maxHeight: self.data.keyboardView == 1 ? 372 : 312,
//                        minHeight: 56
//                    ) {
//                        KeyboardView()
//                            .environmentObject(self.data)
//                            .offset(y: self.keyboardShown ? -8 : 16)
//                    }
//                    .frame(height: self.data.presetsShown ? 32 : (self.keyboardShown ? (self.data.keyboardView == 1 ? 372 : 312) : 56) )
//                    .offset(y: self.data.presetsShown ? (self.keyboardShown ? (self.data.keyboardView == 1 ? 372 : 312) : 56) : 0)
//                }
                
                ZStack(alignment: .bottom) {
                    ContentView()
                        .environmentObject(self.data)
                        .padding(.bottom, self.data.presetsShown ? 32 : (self.keyboardShown ? (self.data.keyboardView == 1 ? 372 : 312) : 56))
                        .animation(self.reduceMotion || UserDefaults.standard.bool(forKey: "reduce_motion") ? nil : (self.keyboardShown ? .easeInOut : nil))
                    
                    if !self.data.presetsShown {
                        BottomSheetView(
                            isOpen: self.$keyboardShown,
                            maxHeight: self.data.keyboardView == 1 ? 372 : 312,
                            minHeight: 56
                        ) {
                            KeyboardView()
                                .environmentObject(self.data)
                                .offset(y: self.keyboardShown ? -8 : 16)
                        }
                        .frame(height: self.data.keyboardView == 1 ? 372 : 312)
                        .transition(.move(edge: .bottom))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .background(
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
            )
            .onAppear{
                UserDefaults.standard.set(false, forKey: "pro")
                UserDefaults.standard.set(false, forKey: "didLaunchBefore")
                UserDefaults.standard.set(false, forKey: "didShowHint")
            }
//            .sheet(isPresented: self.$data.onboarding) {
//                        Splashscreen()
//                        .environmentObject(self.data)
//            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(AppData())
    }
}
