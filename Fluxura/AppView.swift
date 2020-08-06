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
                VStack(spacing: 0) {
                    ContentView()
                        .environmentObject(self.data)

                    BottomSheetView(
                        isOpen: self.$data.keyboardShown,
                        maxHeight: self.data.keyboardView == 1 ? 372 : 312,
                        minHeight: self.data.presetsShown ? 0 : 56
                    ) {
                        KeyboardView()
                            .environmentObject(self.data)
                            .offset(y: self.data.keyboardShown ? -8 : 16)
                    }
                    .frame(height: self.data.presetsShown ? 0 : (self.data.keyboardShown ? (self.data.keyboardView == 1 ? 372 : 312) : 56) )
                    .animation(self.reduceMotion || UserDefaults.standard.bool(forKey: "reduce_motion") ? nil : .easeInOut)
                }
                .edgesIgnoringSafeArea(.bottom)
                
                /// This uses Z-Stacked Elements, but doesn't allow the segmented picker to work
                
//                ZStack(alignment: .bottom) {
//                    ContentView()
//                        .environmentObject(self.data)
//                        .padding(.bottom, self.data.presetsShown ? 0 : (self.keyboardShown ? (self.data.keyboardView == 1 ? 336 : 276) : 24))
//
//                    if !self.data.presetsShown {
//                        BottomSheetView(
//                            isOpen: self.$keyboardShown,
//                            maxHeight: self.data.keyboardView == 1 ? 372 : 312,
//                            minHeight: 56
//                        ) {
//                            KeyboardView()
//                                .environmentObject(self.data)
//                                .offset(y: self.keyboardShown ? -8 : 16)
//                        }
//    //                    .frame(height: self.data.keyboardView == 1 ? 372 : 312)
//                        .edgesIgnoringSafeArea(.bottom)
//                        .animation(self.reduceMotion || UserDefaults.standard.bool(forKey: "reduce_motion") ? nil : (self.keyboardShown ? .easeInOut : nil))
//                        .transition(.move(edge: .bottom))
//                    }
//                }
            }
            .background(
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
            )
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
