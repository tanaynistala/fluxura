//
//  AppIconsView.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/21/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct AppIconsView: View {
    var body: some View {
        var icons: [[Int]] = []
        _ = (1...10).publisher
        .collect(2)
        .collect()
        .sink(receiveValue: {icons = $0})
        
        return
            ForEach(0..<icons.count, id: \.self) { array in
            HStack {
                ForEach(0..<2, id: \.self) { number in
                    VStack {
                        Image("\(SettingsStore.AppIcon.allCases[array*2 + number].rawValue)")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(32)
                            .padding(4)
                            .onTapGesture {
                                UIApplication.shared.setAlternateIconName("\(SettingsStore.AppIcon.allCases[array*2 + number].rawValue)") { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                        print(SettingsStore.AppIcon.allCases[array*2 + number].rawValue)
                                    } else {
                                        print("Success!")
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

struct AppIconsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                AppIconsView()
            }.navigationBarTitle("App Icons")
        }
    }
}
