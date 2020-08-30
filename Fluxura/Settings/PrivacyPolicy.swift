//
//  Privacy Policy.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/25/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import MessageUI

struct PrivacyPolicy: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Personal Data")
                .font(.headline)
            Text("We don't collect anything. Everything you type or do is stored locally, and all processing is done on-device.")
            
            Text("Any Questions?")
                .font(.headline)
            Text("Please don't hesitate to contact us about any queries you may have, about your data or otherwise. We're always happy to help!")
            
            Button(action: {
                UIApplication.shared.open(URL(string: "https://tanaynistala.vercel.app/blog/fluxura-privacy-policy")!)
            }) {
                HStack {
                    Text("Read more")
                    Image(systemName: "arrow.up.right.circle.fill")
                }
                .foregroundColor(
                    UserDefaults.standard.bool(forKey: "reduce_colors") ?
                        Color.gray :
                        Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                )
                .padding(8)
                .background(
                    UserDefaults.standard.bool(forKey: "reduce_colors") ?
                        Color.gray.opacity(0.3) :
                        Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo").opacity(0.3)
                )
                .cornerRadius(8)
            }
            
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
                    .fill(
                        UserDefaults.standard.bool(forKey: "reduce_colors") ?
                        Color.gray :
                        Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                    ))
                .padding(.bottom)
            }
            .disabled(!MFMailComposeViewController.canSendMail())
            .sheet(isPresented: $isShowingMailView) {
                MailView(result: self.$result, message: "")
            }
        }
        .padding(24)
        .navigationBarTitle("Privacy Policy")
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrivacyPolicy()
        }
    }
}
