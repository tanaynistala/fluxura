//
//  Splashscreen.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/25/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct Splashscreen: View {
    @EnvironmentObject var data: AppData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Image("Fourier Pro")
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .frame(width: 180, alignment: .center)
//                .clipShape(RoundedRectangle(cornerRadius: 16))
                .accessibility(hidden: true)

            Text("Welcome to")
                .font(Font.system(.largeTitle).weight(.black))
                .foregroundColor(.black)

            Text("Fourier")
                .font(Font.system(.largeTitle).weight(.black))
                .foregroundColor(Color(UIColor.systemIndigo))
            
            VStack(alignment: .leading) {
                FeatureDetail(
                    title: "Solve",
                    subTitle: "Solve all kinds of ordinary or partial differential equations.",
                    imageName: "equal"
                )
                
                FeatureDetail(
                    title: "Configure",
                    subTitle: "Set the order, number of variables, and linearity instantly.",
                    imageName: "dial"
                )
                
                FeatureDetail(
                    title: "Enter",
                    subTitle: "Enter coefficients as constants or as functions.",
                    imageName: "function"
                )
            
                FeatureDetail(
                    title: "Type",
                    subTitle: "The custom keyboard helps you enter formulae quickly.",
                    imageName: "keyboard"
                )
            }
            .foregroundColor(.black)
            
            Spacer()
            
            Button(action: {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                withAnimation() { self.data.onboarding = false }
            }) {
                Text("Continue")
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
        .background(Color(red: 0.624, green: 0.764, blue: 0.941).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.top)
        .transition(.move(edge: .bottom))
    }
}

struct FeatureDetail: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"
    var color: Color = Color(UIColor.systemIndigo)

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(color)
                .padding()
                .accessibility(hidden: true)
                .frame(width: 64)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .accessibility(addTraits: .isHeader)

                Text(subTitle)
                    .font(.body)
                    .foregroundColor(Color(UIColor.darkGray))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 8)
    }
}

struct Splashscreen_Previews: PreviewProvider {
    static var previews: some View {
        Splashscreen()
    }
}
