//
//  PresetDetailView.swift
//  Fourier
//
//  Created by Tanay Nistala on 7/2/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct PresetDetailView: View {
    @EnvironmentObject var data: PresetData
    var preset: Preset
    var presetIndex: Int {
        data.presets.firstIndex(where: { $0.id == preset.id })!
    }
    @State var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                        if preset.order > 0 {
                            OrderTag(order: preset.order)
                        }
                        
                        ForEach(preset.types, id: \.self) { type in
                            TypeTag(text: type.rawValue, color: .systemOrange)
                        }
                        
                        Spacer()
                    }
                }
                
                Text(preset.description)
                    .font(.callout)
                    .lineLimit(isExpanded ? nil : 3)
                    .padding(.bottom, 2)
                    .animation(.linear)
                
                HStack {
                    Button(action: {self.isExpanded.toggle()}) {
                        HStack {
//                            Text(isExpanded ? "Less" : "More")
                            Image(systemName: "chevron.down")
                                .rotationEffect(.degrees(isExpanded ? -180 : 0))
                            .frame(width: 24, height: 24)
                        }
                    }
                    .buttonStyle(IconButtonStyle())
                    
                    Spacer()
                    
                    Button(action: {UIApplication.shared.open(URL(string: self.preset.url)!)}) {
                        HStack {
                            Text("Read More")
                            Image(systemName: "link")
                                .imageScale(.small)
                        }
                    }
                    .buttonStyle(IconButtonStyle())
                }
                .animation(.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 1))
            }
            .padding()

            Spacer()
        }
        .navigationBarTitle(preset.name)
//        .navigationBarItems(trailing:
//            Button(action: {
//                self.data.presets[self.presetIndex].isFavorite.toggle()
//            }) {
//                if self.data.presets[self.presetIndex].isFavorite {
//                    Image(systemName: "star.fill")
//                        .foregroundColor(Color.yellow)
//                } else {
//                    Image(systemName: "star")
//                        .foregroundColor(Color.gray)
//                }
//            }
//        )
    }
}

struct PresetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let data = PresetData()
        return PresetDetailView(preset: data.presets[0])
        .environmentObject(data)
    }
}
