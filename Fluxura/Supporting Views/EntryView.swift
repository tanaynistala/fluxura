//
//  EntryView.swift
//  Fluxura
//
//  Created by Tanay Nistala on 6/18/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var data: AppData
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    var type: Int
    
    var body: some View {
        ForEach(self.data.inputs[type], id: \.self) { target in
            InputRow(
                target: target,
                isActive: [target.type, target.index] == self.data.activeInput
            )
            .environmentObject(AppData.shared)
            .listRowBackground(
                Group {
                    target.isInvalid ? Color.red.opacity(self.reduceTransparency ? 1 : 0.3) : ([target.type, target.index] == self.data.activeInput ? (
                        self.data.reduceColors ?
                        Color(.systemFill).opacity(self.reduceTransparency ? 1 : 0.8) :
                        Color(self.data.appTint ?? "indigo").opacity(self.reduceTransparency ? 1 : 0.3)
                        ) : Color.clear)
                }
            )
            .onAppear{
                UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            .onTapGesture {
                self.data.activeInput = [target.type, target.index]
            }
            .accessibility(addTraits: .updatesFrequently)
        }
    }
}

struct EntryViews_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            Section {
                EntryView(type: 0)
                    .environmentObject(AppData())
            }
        }
    }
}
