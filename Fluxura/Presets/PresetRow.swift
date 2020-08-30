//
//  PresetRow.swift
//  Fluxura
//
//  Created by Tanay Nistala on 7/3/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct PresetRow: View {
    @EnvironmentObject var data: AppData
    var preset: Preset
    var color: UIColor {
        switch preset.subject {
        case .physics:
            return .systemBlue
        case .chemistry:
            return .systemRed
        case .biology:
            return .systemGreen
        case .economics:
            return .systemTeal
        default:
            return .systemIndigo
        }
    }
    
    var body: some View {
        HStack {
            if !UserDefaults.standard.bool(forKey: "reduce_colors") {
                Rectangle()
                    .frame(width: 8)
                    .foregroundColor(Color(color))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(preset.name)
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if preset.order > 0 {
                            OrderTag(order: preset.order)
                            .fixedSize(horizontal: true, vertical: true)
                        }
                        ForEach(preset.types, id: \.self) { type in
                            TypeTag(text: type.rawValue, color: .systemOrange)
                            .fixedSize(horizontal: true, vertical: true)
                        }
                    }
                }
            }
            .padding(.vertical, UserDefaults.standard.bool(forKey: "reduce_colors") ? 0 : 8)
            
            Spacer()
            
            if self.data.loadedPreset?.name == self.preset.name {
                Image(systemName: "checkmark.circle.fill")
                    .imageScale(.large)
                    .font(.headline)
                    .foregroundColor(self.data.reduceColors ? Color(.systemGray4) : Color(self.data.appTint ?? "indigo"))
            }
        }
    }
}

struct PresetRow_Previews: PreviewProvider {
    static var previews: some View {
        PresetRow(preset: Presets().presets.last!)
            .previewLayout(.fixed(width: 300, height: 64))
            .environmentObject(AppData.shared)
    }
}
