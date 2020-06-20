//
//  ContentView.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/15/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var solver = Solver()
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    @State var settingsShown = false
    
    /// Button(action: {print(self.solver.RungeKutta(model: self.solver.LotkaVolteraModel(t:x:parameters:), x0: [20, 5], t0: 0, tf: 100, dt: 0.01).1[1][1])}){Text("Toggle")}
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Solver")
                    .accessibility(addTraits: [.isHeader, .isStaticText])
                    .font(Font.system(.largeTitle).weight(.bold))
                Spacer()
                Button(action: {
                    self.settingsShown.toggle()
                    if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                }) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                        .font(Font.system(size: 16).weight(.bold))
                        .frame(width: 32, height: 32)
                }
                .buttonStyle(IconButtonStyle())
                .sheet(isPresented: self.$settingsShown, onDismiss: {self.data.refresh()}) {
                    SettingsView()
                        .environmentObject(SettingsStore())
                }
                .accessibility(label: Text("Settings"))
            }
            .foregroundColor(
                UserDefaults.standard.bool(forKey: "reduce_colors") ?
                Color.primary :
                Color(UserDefaults.standard.string(forKey: "app_tint") ?? "blue")
            )
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            
            Form {
                Section(
//                        header: Text("Equation Setup").font(.headline),
                    footer: Text("Nonlinear differential equations are not supported yet.")
                ) {
                    HStack {
                        Text("Type")
                        Spacer()
                        Picker(selection: self.$data.type, label: Text("Type")) {
                            Text("Ordinary").tag(1)
                            Text("Partial").tag(2)
                        }
                        .animation(.none)
                        .pickerStyle(SegmentedPickerStyle())
                        .fixedSize(horizontal: true, vertical: true)
                    }
                    
                    HStack {
                        Image(systemName: "\(self.data.order).square")
                            .accessibility(hidden: true)
                            .imageScale(.large)
                            .font(.headline)
                        
                        Stepper("Order", value: self.$data.order, in: 1...(self.data.type == 1 ? 4 : 8), onEditingChanged: {_ in
                            if self.data.activeInput >= self.data.order {
                                self.data.activeInput = self.data.order - 1
                            }
                            
                            if self.data.order < self.data.inputs.count {
                                while self.data.order < self.data.inputs.count {
                                    self.data.inputs.removeLast()
                                }
                            } else if self.data.order > self.data.inputs.count {
                                while self.data.order > self.data.inputs.count {
                                    self.data.inputs.append("")
                                }
                            }
                            
                            if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                                UISelectionFeedbackGenerator().selectionChanged()
                            }
                        })
                        .animation(.none)
                    }
                    
                    Toggle("Linear", isOn: self.$data.isLinear)
                        .disabled(true)
                }
                
                Section(header: ClearFieldsView().environmentObject(self.data)) {
                    CoefficientsView()
                        .environmentObject(self.data)
                }
                
                Section {
                    Text("= Answer")
                        .font(Font.system(.title).weight(.semibold))
                        .foregroundColor(
                            UserDefaults.standard.bool(forKey: "reduce_colors") ?
                            Color.primary :
                            Color(UserDefaults.standard.string(forKey: "app_tint") ?? "blue")
                        )
                }
            }
            .environment(\.horizontalSizeClass, .regular)
            .onAppear {
                UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppData())
    }
}
