//
//  FitzHughNagumo.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/7/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

extension Solver {
    func FitzHughNagumo(t: Double, x: [Double], params: [Double]) -> [Double] {
        let tau = params[0]
        let a = params[1]
        let b = params[2]
        let I = params[3]
        
        let xDot: [Double] = [x[0] - pow(x[0], 3)/3 - x[1] + I, (x[0] - b*x[1] + a) / tau]
        return xDot
    }
}
