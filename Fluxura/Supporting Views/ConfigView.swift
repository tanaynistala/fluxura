//
//  ConfigView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/8/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct ConfigView: View {
    @EnvironmentObject var data: AppData
    
    var body: some View {
        Group {
            if self.data.loadedPreset == nil {
                Section(
                    header: HStack {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                            Text("Configuration")
                        }.font(.headline)
                        Spacer()
                        ResetFieldsView().environmentObject(AppData.shared)
                    }
                ) {
                    if self.data.loadedPreset == nil {
                        /*
                        HStack {
                            Text("Type")
                            Spacer()
                            Picker(selection: self.$data.type, label: Text("Type")) {
                                Text("Ordinary").tag(1)
                                Text("Partial").tag(2)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .fixedSize(horizontal: true, vertical: true)
                        }
                        */
                    
                        HStack {
                            Image(systemName: "\(self.data.order).square")
                                .accessibility(hidden: true)
                                .imageScale(.large)
                                .font(.headline)
                            
                            Stepper("Order", value: self.$data.order, in: 1...4, onEditingChanged: {_ in
                                if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                                    UISelectionFeedbackGenerator().selectionChanged()
                                }
                            })
                        }
                        
                        /*
                        HStack {
                            Text("Linearity")
                            Spacer()
                            Picker(selection: self.$data.isLinear, label: Text("Linearity")) {
                                Text("Linear").tag(true)
                                Text("Nonlinear").tag(false)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .fixedSize(horizontal: true, vertical: true)
                        }
                         */
                        
                        /*
                        if self.data.type == 2 {
                            HStack {
                                ForEach(0..<3, id: \.self) { item in
                                    Image(systemName: "\(self.vars[item]).square\(item < self.data.vars ? ".fill" : "")")
                                        .imageScale(.large)
                                        .font(.headline)
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(
                                            UserDefaults.standard.bool(forKey: "reduce_colors") ?
                                            Color.primary :
                                                (item < self.data.vars ? Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo") : Color.primary)
                                        )
                                        .onTapGesture {
                                            self.data.vars = item+1
                                            if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                                                UISelectionFeedbackGenerator().selectionChanged()
                                            }
                                    }
                                }

                                Stepper("Variables", value: self.$data.vars, in: 1...3, onEditingChanged: {_ in
                                    if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                                        UISelectionFeedbackGenerator().selectionChanged()
                                    }
                                })
                            }
                        }
                         */
                    }
                    
                    /*
                    if self.data.showMenu {
                        HStack {
                            Text("Angles")
                            Spacer()
                            Picker(selection: $data.angleType, label: Text("Angles")) {
                                Text("Degrees").tag(1)
                                Text("Radians").tag(2)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .fixedSize(horizontal: true, vertical: true)
                        }
                        .padding(.vertical, 4)

                        Stepper(value: $data.precision, in: 0...10, onEditingChanged: {_ in
                            if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                                UISelectionFeedbackGenerator().selectionChanged()
                            }
                            print(self.data.precision)
                        }) {
                            HStack {
                                Image(systemName: "\(data.precision).square")
                                .accessibility(hidden: true)
                                .imageScale(.large)
                                .font(.headline)
                                Text("Precision")
                            }
                            .padding(.vertical, 4)
                        }
                    }
                     */
                }
            }
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
        ConfigView()
            .environmentObject(AppData.shared)
        }
    }
}
