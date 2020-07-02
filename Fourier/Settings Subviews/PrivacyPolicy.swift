//
//  Privacy Policy.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/25/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct PrivacyPolicy: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Personal Data")
                .font(.headline)
            Text("We don't collect anything. Everything you type or do is stored locally, and all processing is done on-device.")
            
            Text("Any Questions?")
                .font(.headline)
            Text("Please don't hesitate to contact us about any queries you may have, about your data or otherwise. We're always happy to help!")
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
        .navigationBarTitle("Privacy Policy")
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicy()
    }
}