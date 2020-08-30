//
//  SubjectPicker.swift
//  Fluxura
//
//  Created by Tanay Nistala on 7/2/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct SubjectPickerItem: View {
    var title: String
    var isSelected: Bool
    var color: UIColor {
        switch title {
        case "Physics":
            return .systemBlue
        case "Chemistry":
            return .systemRed
        case "Biology":
            return .systemGreen
        case "Economics":
            return .systemTeal
        default:
            return .systemIndigo
        }
    }
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(
                isSelected ? Color.white :
                (UserDefaults.standard.bool(forKey: "reduce_colors") ?
                    Color(.systemGray4) :
                Color(color))
            )
            .padding(8)
            .background(
                UserDefaults.standard.bool(forKey: "reduce_colors") ?
                Color(.systemGray4).opacity(isSelected ? 1 : 0) :
                Color(color).opacity(isSelected ? 1 : 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .animation(.interactiveSpring())
    }
}

struct SubjectPicker: View {
    @EnvironmentObject var data: AppData

    var body: some View {
        HStack {
            ForEach(Preset.Subject.allCases, id: \.self) { subject in
                Button(action: {
                    self.data.selectedField = subject.rawValue
                }) {
                    SubjectPickerItem(title: subject.rawValue, isSelected: subject.rawValue == self.data.selectedField)
                }
            }
        }

    }
}

struct SubjectPicker_Previews: PreviewProvider {
    static var previews: some View {
        SubjectPicker()
        .environmentObject(AppData())
    }
}
