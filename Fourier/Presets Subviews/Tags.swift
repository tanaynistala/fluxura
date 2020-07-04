//
//  Tags.swift
//  Fourier
//
//  Created by Tanay Nistala on 7/2/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct TypeTag: View {
    @State var text: String
    @State var color: UIColor
    
    var body: some View {
        Text(text)
            .font(.footnote)
            .fontWeight(.semibold)
            .padding(4)
            .foregroundColor(Color(color))
            .background(Color(color).opacity(0.2))
            .cornerRadius(4)
            .onAppear{
                if self.text == "Nonlinear" {
                    self.color = .systemRed
                } else if self.text == "Linear" {
                    self.color = .systemGreen
                }
        }
    }
}

struct OrderTag: View {
    @State var order: Int
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "\(order).square")
                .font(.headline)
            Text("Order")
                .font(.footnote)
                .fontWeight(.semibold)
        }
        .padding(4)
        .foregroundColor(Color(.systemIndigo))
        .background(Color(.systemIndigo).opacity(0.2))
        .cornerRadius(4)
    }
}
