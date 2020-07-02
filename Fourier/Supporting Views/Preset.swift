//
//  Preset.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/30/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

enum Subject: String, CaseIterable {
    case all = "All"
    case physics = "Physics"
    case biology = "Biology"
    case chemistry = "Chemistry"
    case cs = "Computer Science"
}

struct Preset: Hashable {
    var subject: Subject = .biology
    var title: String = ""
    var order: Int?
    var types: [Type]
}

struct OrderTag: View {
    @State var order: Int?
    
    var body: some View {
        HStack {
            if order != nil {
                HStack(spacing: 4) {
                    Text("Order")
                    Image(systemName: "\(order!).square")
                    .font(.body)
                }
                .tagStyle(color: UIColor.systemIndigo)
            }
        }
    }
}

struct LinearTag: View {
    @State var isLinear: Bool
    
    var body: some View {
        Text(isLinear ? "Linear" : "Nonlinear")
        .tagStyle(color: isLinear ? UIColor.systemGreen : UIColor.systemPink)
    }
}

enum Type: String, CaseIterable {
    case pde = "PDE"
    case ode = "ODE"
    case homo = "Homogeneous"
    case hetero = "Heterogeneous"
    case linear = "Linear"
    case nonlinear = "Nonlinear"
}

struct TypeTag: View {
    @State var type: Type
    
    var body: some View {
        VStack {
            if (type != .linear) && (type != .nonlinear) {
                Text(type.rawValue)
                    .tagStyle(color: UIColor.systemOrange)
            } else {
                LinearTag(isLinear: (type == .linear))
            }
        }
    }
}

struct TagStyle: ViewModifier {
    var color: UIColor = UIColor.systemIndigo
    
    func body(content: Content) -> some View {
        content
            .font(Font.system(.footnote).weight(.semibold))
            .foregroundColor(Color(color))
            .padding(4)
            .background(Color(color).opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

extension View {
    func tagStyle(color: UIColor) -> some View {
        self.modifier(TagStyle(color: color))
    }
}
