//
//  BassDiffusion.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/6/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

extension Solver {
    func BassDiffusion(t: Double, x: [Double], params: [Double]) -> [Double] {
        let p = params[0]
        let q = params[1]
        
        let xDot: [Double] = [(p + q * x[0]) * (1 - x[0])]
        return xDot
    }
}
