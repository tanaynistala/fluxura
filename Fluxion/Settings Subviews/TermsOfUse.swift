//
//  TermsOfService.swift
//  Fluxion
//
//  Created by Tanay Nistala on 6/25/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import MessageUI

struct TermsOfUse: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Free Version")
                .font(.headline)
            Text("The free version of Fluxion enables basic, linear differential equations to be solved.")
            
            Text("Fluxion Pro")
                .font(.headline)
            Text("Fluxion Pro is enabled through a one-time purchase or a recurring, cancelable subscription. This unlocks all features, including non-linear differential equations, presets, and app customization options.")
            Spacer()
            Button(action: {
                self.isShowingMailView.toggle()
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
            .disabled(!MFMailComposeViewController.canSendMail())
            .sheet(isPresented: $isShowingMailView) {
                MailView(result: self.$result)
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
