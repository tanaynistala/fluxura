//
//  Splashscreen.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/25/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct Splashscreen: View {
    @EnvironmentObject var data: AppData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack {
                Image("Fluxura Pro")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .accessibility(hidden: true)

                Text("Welcome to")
                    .font(Font.system(.largeTitle).weight(.black))
                    .foregroundColor(.black)

                Text("Fluxura")
                    .font(Font.system(.largeTitle).weight(.black))
                    .foregroundColor(Color(.systemIndigo))
                
                VStack(alignment: .leading) {
                    FeatureDetail(
                        title: "Solve",
                        subTitle: "Solve all kinds of ordinary differential equations.",
                        imageName: "equal"
                    )
                    
                    FeatureDetail(
                        title: "Configure",
                        subTitle: "Easily set the order of an equation, or load a commonly-used preset.",
                        imageName: "dial"
                    )
                    
                    FeatureDetail(
                        title: "Enter",
                        subTitle: "Enter time ranges, parameters, and initial conditions as constants or expressions.",
                        imageName: "function"
                    )
                
                    FeatureDetail(
                        title: "Type",
                        subTitle: "Use the custom keyboard to enter expressions quickly.",
                        imageName: "keyboard"
                    )
                }
                .foregroundColor(.black)
                .padding()
                
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
                            .fill(Color(.systemIndigo)))
                        .padding(.bottom)
                }
                .padding(.horizontal)
            }
            .transition(.move(edge: .bottom))
        }
        .background(Color(red: 0.624, green: 0.764, blue: 0.941).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.top)
    }
}

struct FeatureDetail: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"
    var color: Color = Color(.systemIndigo)

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
                    .foregroundColor(Color(.darkGray))
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
