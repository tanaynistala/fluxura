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
        }
        .padding()
        .navigationBarTitle("Privacy Policy")
    }
}

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicy()
    }
}
