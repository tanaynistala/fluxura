//
//  PresetsView.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/29/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct PresetsView: View {
    @State var activeField: Subject = .all
    @State var showFilter: Bool = true
    
    @State var presets: [Preset] = [
        Preset(subject: .biology, title: "Lotka-Volterra", order: 1, types: [.nonlinear, .hetero]),
        Preset(subject: .chemistry, title: "Rate Equation", types: [.pde]),
        Preset(subject: .physics, title: "Heat Equation", order: 1, types: [.linear, .pde, .homo]),
        Preset(subject: .physics, title: "Navier-Stokes", types: [.nonlinear, .ode, .hetero]),
        Preset(subject: .physics, title: "Euler-Lagrange", order: 2, types: [.pde]),
        Preset(subject: .physics, title: "Eikonal", types: [.nonlinear, .pde]),
        Preset(subject: .physics, title: "Korteweg-de Vries", types: [.nonlinear, .pde]),
        Preset(subject: .physics, title: "Laplace", order: 2, types: [.pde]),
        Preset(subject: .physics, title: "Lorenz", types: [.ode]),
        Preset(subject: .physics, title: "Poisson", types: [.pde]),
        Preset(subject: .physics, title: "Poisson-Boltzmann", order: 2, types: [.pde])
    ]
    
    var body: some View {
        Form {
            if showFilter {
                Section(header: Text("Filters").font(.headline)) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        SubjectPicker(field: $activeField).padding()
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            
            Section {
                ForEach(presets, id: \.self) { preset in
                    Group {
                        if self.activeField == .all || preset.subject == self.activeField {
                            NavigationLink(destination: EmptyView()) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(preset.title)
                                        .font(.headline)
    //                                            ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
    //                                                LinearTag(isLinear: preset.isLinear)
                                        OrderTag(order: preset.order)
                                        ForEach(preset.types, id: \.self) { type in
                                            TypeTag(type: type)
                                        }
                                        Spacer()
                                    }
    //                                            }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
            }
        }
        .environment(\.horizontalSizeClass, .regular)
        .onAppear {
            UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 24))
        }
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
            .navigationBarTitle("Presets")
        }
    }
}

struct SubjectPickerItem: View {
    @Binding var activeField: Subject
    @State var subject: Subject
    @State var text: String = ""
    
    var body: some View {
        Text(text)
//            .font(Font.system(activeField == subject ? .title : .title).weight(activeField == subject ? .semibold : .regular))
            .font(.headline)
            .foregroundColor(activeField == subject ? Color.white : Color(UIColor.systemIndigo))
            .padding(8)
            .background(Color(UIColor.systemIndigo).opacity(activeField == subject ? 1 : 0))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .animation(.interactiveSpring())
    }
}

struct SubjectPicker: View {
    @Binding var field: Subject
    @State var subjects = Subject.allCases
    
    var body: some View {
        HStack {
            ForEach(subjects, id: \.self) { subject in
                Button(action: {
                    withAnimation(.interactiveSpring()) {
                        self.field = subject
                    }
                }) {
                    SubjectPickerItem(activeField: self.$field, subject: subject, text: subject.rawValue)
                }
            }
        }
        
    }
}

