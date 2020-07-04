//
//  PresetsView.swift
//  Fourier
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
                ForEach(presetData, id: \.self) { preset in
                    Group {
                        if self.data.selectedField == "All" ||
//                        (self.data.selectedField == "Favorites" && preset.isFavorite) ||
                        (self.data.selectedField == preset.subject.rawValue) {
                            VStack {
                                NavigationLink(destination: PresetDetailView(preset: preset)) {
                                    PresetRow(preset: preset)
                                }
                            }
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                        }
                    }
                }
            }
        }
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarItems(trailing:
            Button(action: {
                withAnimation(.spring()) {
                    self.showFilter.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle\(self.showFilter ? ".fill" : "")")
                    .imageScale(.large)
                    .foregroundColor(Color(UIColor.systemIndigo))
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
