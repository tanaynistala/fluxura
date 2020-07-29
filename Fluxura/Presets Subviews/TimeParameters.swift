//
//  TimeParameters.swift
//  Fluxura
//
//  Created by Tanay Nistala on 7/9/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct TimeParameters: View {
    @Binding var t0: String
    @Binding var tf: String
    @Binding var dt: String
    
    var body: some View {
        Section {
            HStack {
                Image(systemName: "play.fill")
                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .green)
                TextField("Initial Time", text: $t0)
                    .keyboardType(.decimalPad)
            }
            
            HStack {
                Image(systemName: "stop.fill")
                    .foregroundColor(UserDefaults.standard.bool(forKey: "reduce_colors") ? .primary : .red)
                TextField("Final Time", text: $t0)
                    .keyboardType(.decimalPad)
            }
            
            if SettingsStore().isPro {
                HStack {
                    Image(systemName: "timer")
                        .foregroundColor(.primary)
                    TextField("Time Interval", text: $dt)
                        .keyboardType(.decimalPad)
                }
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
        }
    }
}
