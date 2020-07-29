//
//  PresetsView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/29/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct PresetsView: View {
    @EnvironmentObject var data: PresetData
    @State var showFilter: Bool = true
    
    var body: some View {
        Form {
            if showFilter {
                Section(header: Text("Filters").font(.headline)) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        SubjectPicker()
                            .padding()
                            .environmentObject(self.data)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            
            Section {
                ForEach(0..<data.presets.count, id: \.self) { preset in
                    Group {
                        if self.data.selectedField == "All" ||
//                        (self.data.selectedField == "Favorites" && preset.isFavorite) ||
                            (self.data.selectedField == self.data.presets[preset].subject.rawValue) {
                            VStack {
                                NavigationLink(destination: PresetDetailView(preset: self.data.presets[preset])) {
                                    PresetRow(preset: self.data.presets[preset])
                                }
                            }
                            .listRowInsets(UserDefaults.standard.bool(forKey: "reduce_colors") ? nil : EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                        }
                    }
                }
            }
        }
        .environment(\.horizontalSizeClass, .regular)
        .onAppear{UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 56, right: 0)}
        .navigationBarItems(trailing:
            Button(action: {
                withAnimation(.spring()) {
                    self.showFilter.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle\(self.showFilter ? ".fill" : "")")
                    .imageScale(.large)
                    .foregroundColor(
                        UserDefaults.standard.bool(forKey: "reduce_colors") ?
                        Color.primary :
                        Color(UserDefaults.standard.string(forKey: "app_tint") ?? "indigo")
                    )
                    .font(.headline)
                .frame(width: 24, height: 24)
            }
            .buttonStyle(IconButtonStyle())
        )
    }
}

struct PresetsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PresetsView()
            .environmentObject(PresetData())
            .navigationBarTitle("Presets")
        }
    }
}
