//
//  PresetRow.swift
//  Fourier
//
//  Created by Tanay Nistala on 7/3/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct PresetRow: View {
    var preset: Preset
    var color: UIColor {
        switch preset.subject {
        case .physics:
            return .systemBlue
        case .chemistry:
            return .systemRed
        case .biology:
            return .systemGreen
        case .cs:
            return .systemTeal
        default:
            return .systemIndigo
        }
    }
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 8)
                .foregroundColor(Color(color))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(preset.name)
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if preset.order > 0 {
                            OrderTag(order: preset.order)
                        }
                        
                        ForEach(preset.types, id: \.self) { type in
                            TypeTag(text: type.rawValue, color: .systemOrange)
                        }
                        
                        Spacer()
                    }
                }
            }
            .padding(.vertical, 8)
        }
    }
}

struct PresetRow_Previews: PreviewProvider {
    static var previews: some View {
        PresetRow(preset: presetData[0])
            .previewLayout(.fixed(width: 300, height: 64))
    }
}
