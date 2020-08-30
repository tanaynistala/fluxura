//
//  Trig.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/15/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct Extended: View {
    @EnvironmentObject var data: AppData
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 8) {
                HStack {
                    TrigButton(label: "sin", size: 44, text: "sin(").environmentObject(AppData.shared)
                    TrigButton(label: "csc", size: 44, text: "csc(").environmentObject(AppData.shared)
                    TrigButton(label: "asin", size: 44, text: "asin(").environmentObject(AppData.shared)
                    TrigButton(label: "acsc", size: 44, text: "acsc(").environmentObject(AppData.shared)
                }
                HStack {
                    TrigButton(label: "cos", size: 44, text: "cos(").environmentObject(AppData.shared)
                    TrigButton(label: "sec", size: 44, text: "sec(").environmentObject(AppData.shared)
                    TrigButton(label: "acos", size: 44, text: "acos(").environmentObject(AppData.shared)
                    TrigButton(label: "asec", size: 44, text: "asec(").environmentObject(AppData.shared)
                }
                HStack {
                    TrigButton(label: "tan", size: 44, text: "tan(").environmentObject(AppData.shared)
                    TrigButton(label: "cot", size: 44, text: "cot(").environmentObject(AppData.shared)
                    TrigButton(label: "atan", size: 44, text: "atan(").environmentObject(AppData.shared)
                    TrigButton(label: "acot", size: 44, text: "acot(").environmentObject(AppData.shared)
                }
            }
            Spacer()
        }
    }
}

struct Extended_Previews: PreviewProvider {
    static var previews: some View {
        Extended().environmentObject(AppData())
    }
}
