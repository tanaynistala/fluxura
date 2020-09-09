//
//  ContentView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/15/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data: AppData
    
    @State private var isiPad = UIDevice.current.userInterfaceIdiom == .pad

    @State var proPreviewShown = false
    let vars = ["x", "y", "z"]
    
    var body: some View {
        VStack {
            if isiPad {
                NavigationView {
                    Inputs()
                    .environmentObject(AppData.shared)
                    
                    if isiPad /*&& UserDefaults.standard.bool(forKey: "pro")*/ {
                        PresetsView()
                            .environmentObject(AppData.shared)
                    } else {
                        VStack {
                            Image(systemName: "lock.fill")
                                .imageScale(.large)
                                .font(.title)
                            Text("Get Fluxura Pro to unlock Presets")
                        }
                    }
                }
                .padding(.leading, UserDefaults.standard.bool(forKey: "isPro") ? 1 : 0)
            } else {
                NavigationView {
                    Inputs()
                    .environmentObject(AppData.shared)
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppData())
    }
}

struct Inputs: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    @State private var isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    @State var settingsShown = false
    
    var body: some View {
        Form {
            ConfigView()
                .environmentObject(AppData.shared)
            
            Section(header: HStack {
                HStack {
                    Image(systemName: "stopwatch")
                    Text("Time Span")
                }
                .font(.headline)
                Spacer()
                ClearFieldsView(target: 0).environmentObject(AppData.shared)
            }) {
                EntryView(type: 0)
                    .environmentObject(AppData.shared)
                    .alert(isPresented: $data.isTimeIntervalInvalid) {
                        Alert(title: Text("Time Interval Invalid"), message: Text("The time interval must be greater than 0.01 seconds, and must be less than the time span."), dismissButton: .cancel(Text("OK")))
                    }
            }
            .alert(isPresented: $data.isTimeSpanInvalid) {
                Alert(title: Text("Time Span Invalid"), message: Text("The time span must be less than 600 seconds, and the final time must be greater than the initial time."), dismissButton: .cancel(Text("OK")))
            }
            
            if self.data.loadedPreset == nil {
                Section(header: HStack {
                    HStack {
                        Image(systemName: "function")
                        Text("Equation")
                    }
                    .font(.headline)
                }) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        if self.data.loadedPreset == nil {
                            EquationView()
                                .padding()
                                .environmentObject(AppData.shared)
                            
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            
            Section(header: HStack {
                HStack {
                    Image(systemName: "\(self.data.inputs[1].count).square")
                        .imageScale(.large)
                    Text("Parameter\(self.data.inputs[1].count == 1 ? "" : "s")")
                }
                .font(.headline)
                Spacer()
                ClearFieldsView(target: 1).environmentObject(AppData.shared)
            }) {
                EntryView(type: 1)
                    .environmentObject(AppData.shared)
            }
            
            Section(header: HStack {
                HStack {
                    Image(systemName: "\(self.data.inputs[2].count).square")
                        .imageScale(.large)
                    Text("Initial Condition\(self.data.inputs[2].count == 1 ? "" : "s")")
                }
                .font(.headline)
                Spacer()
                ClearFieldsView(target: 2).environmentObject(AppData.shared)
            }) {
                EntryView(type: 2)
                    .environmentObject(AppData.shared)
            }
            
            if self.data.answer != [] {
                Section(header: HStack {
                    HStack {
                        Image(systemName: "equal.square")
                            .imageScale(.large)
                        Text("Answer\(self.data.answer.count == 1 ? "" : "s")")
                    }
                    .font(.headline)
                }) {
                    AnswerRow()
                        .environmentObject(AppData.shared)
                }
                .foregroundColor(
                    UserDefaults.standard.bool(forKey: "reduce_colors") ?
                        Color.primary :
                        Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                )
                    .alert(isPresented: self.$data.isInvalid) {
                        Alert(
                            title: Text("Invalid Input"),
                            message: Text("\(data.invalidCount+1) input\(data.invalidCount == 0 ? "" : "s") \(data.invalidCount == 0 ? "is" : "are") invalid, and \(data.invalidCount == 0 ? "has" : "have") been highlighted in red."),
                            dismissButton: .cancel(Text("OK"))
                        )
                }
            }
            
            Spacer(minLength: self.data.presetsShown ? 0 : (self.data.keyboardShown ? (self.data.keyboardView == 1 ? 324 : 264) : 48))
                .listRowBackground(Color(.systemGroupedBackground))
        }
        .environment(\.horizontalSizeClass, .regular)
        .onAppear{ UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude)) }
        .navigationBarTitle(self.data.loadedPreset?.name ?? "Generic ODE")
        .navigationBarItems(trailing:
            HStack {
                if !isiPad /*&& UserDefaults.standard.bool(forKey: "pro")*/  {
                    NavigationLink(
                        destination:
                        PresetsView()
                            .environmentObject(AppData.shared),
                        isActive: self.$data.presetsShown) {
                            Image(systemName: "square.stack.3d.down.right\(self.data.presetsShown ? ".fill" : "")")
                                .font(.headline)
                                .frame(width: 24, height: 24)
                    }
                    .buttonStyle(IconButtonStyle())
                    .accessibility(label: Text("Presets"))
                }
                
                Button(action: {
                    self.settingsShown.toggle()
                    if UserDefaults.standard.bool(forKey: "haptics_enabled") {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                }) {
                    Image(systemName: "gear")
                        .font(.headline)
                        .frame(width: 24, height: 24)
                        .rotationEffect(.degrees(self.reduceMotion || UserDefaults.standard.bool(forKey: "reduce_motion") ? 0 : (self.settingsShown ? 180 : 0)))
                        .animation(.spring())
                }
                .buttonStyle(IconButtonStyle())
                .sheet(isPresented: self.$settingsShown, onDismiss: {self.data.refresh()}) {
                    SettingsView()
                        .environmentObject(SettingsStore.shared)
                        .environmentObject(AppData.shared)
                }
                .accessibility(label: Text("Settings"))
            }
            .foregroundColor(
                UserDefaults.standard.bool(forKey: "reduce_colors") ?
                    Color.primary :
                    Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
            )
        )
    }
}
