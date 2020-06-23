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
        GeometryReader { geometry in
//            if geometry.size.width < geometry.size.height {
                VStack(spacing: 0) {
                    ContentView()
                        .environmentObject(self.data)
                    
                    BottomSheetView(
                        isOpen: self.$keyboardShown,
                        maxHeight: self.data.keyboardView == 1 ? 372 : 312,
                        minHeight: 56
                    ) {
                        KeyboardView()
                            .environmentObject(self.data)
                            .offset(y: self.keyboardShown ? -8 : 16)
                    }
                    .frame(height: self.keyboardShown ? (self.data.keyboardView == 1 ? 372 : 312) : 56 )
                }
//            } else {
//                HStack(spacing: 0) {
//                    ContentView()
//                        .environmentObject(self.data)
//
//                    KeyboardView()
//                        .environmentObject(self.data)
//                        .offset(y: 8)
//                        .background(
//                            RoundedRectangle(cornerRadius: 16)
//                                .foregroundColor(Color(UIColor.systemGray6))
//                                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.25), radius: 5)
//                        )
//                        .animation(self.reduceMotion || UserDefaults.standard.bool(forKey: "reduce_motion") ? .easeInOut : .interactiveSpring(response: 0.35, dampingFraction: 0.75, blendDuration: 0.5))
//                }
//            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
        )
            .onAppear{UserDefaults.standard.set(false, forKey: "pro")}
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(AppData())
//            .environment(\.colorScheme, .dark)
    }
}
