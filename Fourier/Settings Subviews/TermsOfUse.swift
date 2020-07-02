//
//  TermsOfService.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/25/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct TermsOfUse: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Free Version")
                .font(.headline)
            Text("The free version of Fourier enables basic, linear differential equations to be solved.")
            
            Text("Fourier Pro")
                .font(.headline)
            Text("Fourier Pro is enabled through a one-time purchase or a recurring, cancelable subscription. This unlocks all features, including non-linear differential equations, and app customization options.")
            Spacer()
            Button(action: {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }) {
                Text("Contact Us")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color(UIColor.systemIndigo)))
                    .padding(.bottom)
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationBarTitle("Terms of Use")
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TermsOfUse_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfUse()
    }
}
