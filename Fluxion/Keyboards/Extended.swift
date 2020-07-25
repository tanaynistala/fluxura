//
//  Trig.swift
//  Fluxion
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
                    TrigButton(label: "sin", size: 44, text: "sin(").environmentObject(self.data)
                    TrigButton(label: "csc", size: 44, text: "csc(").environmentObject(self.data)
                    TrigButton(label: "asin", size: 44, text: "asin(").environmentObject(self.data)
                    TrigButton(label: "acsc", size: 44, text: "acsc(").environmentObject(self.data)
                }
                HStack {
                    TrigButton(label: "cos", size: 44, text: "cos(").environmentObject(self.data)
                    TrigButton(label: "sec", size: 44, text: "sec(").environmentObject(self.data)
                    TrigButton(label: "acos", size: 44, text: "acos(").environmentObject(self.data)
                    TrigButton(label: "asec", size: 44, text: "asec(").environmentObject(self.data)
                }
                HStack {
                    TrigButton(label: "tan", size: 44, text: "tan(").environmentObject(self.data)
                    TrigButton(label: "cot", size: 44, text: "cot(").environmentObject(self.data)
                    TrigButton(label: "atan", size: 44, text: "atan(").environmentObject(self.data)
                    TrigButton(label: "acot", size: 44, text: "acot(").environmentObject(self.data)
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
