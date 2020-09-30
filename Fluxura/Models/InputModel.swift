//
//  InputModel.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/7/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct Input: Hashable, Identifiable {
    var id = UUID()
    var type: Int
    var index: Int
    var value: String
    var cursorLocation: Int
    var isInvalid: Bool = false
}
