//
//  TipJarView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 7/29/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct TipJar: View {
    let titles = ["A generous tip", "A hefty tip", "A lavish tip"]
    let amounts = ["0.99", "4.99", "9.99"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("If you feel like going above and beyond to support the app and the devs behind it, we'd greatly appreciate extra tips.")
            Text("To be clear, these don't unlock any extra functionality.")
                .foregroundColor(Color(.secondaryLabel))
            
            ForEach(0..<3) {index in
                TipButton(title: self.titles[index], amount: self.amounts[index], index: index+1)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Tip Jar")
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TipJar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        NavigationView {
            TipJar()
        }
        .environment(\.colorScheme, .dark)
            
            NavigationView {
                TipJar()
            }
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
                .foregroundColor(Color(.systemRed))
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
                                Color.primary :
                                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                            )
                    )
            }
        }
        .padding()
        .background(Color(colorScheme == .dark ? .systemGray5 : .white))
        .cornerRadius(16)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 8, y: 2)
    }
}
