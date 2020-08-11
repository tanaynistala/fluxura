//
//  AnswerRow.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/6/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct AnswerRow: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        ForEach(0..<self.data.answer.count, id: \.self) { index in
            HStack {
                if self.data.loadedPreset == nil {
                    if self.data.type == 1 {
                        Group {
                            Text("f ").italic()
                                +
                            Text("(\(index))")
                                .italic()
                                .font(Font.system(.footnote, design: .serif))
                                .baselineOffset(6.0)
                            +
                            Text(" = ")
                                .italic()
                        }
                        .font(Font.system(.body, design: .serif))
                    } else {
                        CoefficientsList().list[self.data.vars - 1][index]
                            .font(Font.system(.body, design: .serif))
                            .italic()
                        +
                        Text(" = ")
                        .italic()
                    }
                } else {
                    if index < self.data.inputs[2].count {
                        Text("\(self.data.loadedPreset?.initial[index] ?? "") = ")
                    }
                }
                
                Text("\(self.data.answer[index])")
                    .font(UserDefaults.standard.bool(forKey: "large_text") ? Font.system(.title, design: .monospaced).weight(.semibold) : Font.system(.headline, design: .monospaced))
            }
        }
    }
}


struct AnswerRow_Previews: PreviewProvider {
    static var previews: some View {
        AnswerRow()
            .environmentObject(AppData())
    }
}
