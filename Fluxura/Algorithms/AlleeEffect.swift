//
//  AlleeEffect.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/7/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

extension Solver {
    func AlleeEffect(t: Double, x: [Double], params: [Double]) -> [Double] {
        let N = x[0]
        let r = params[0]
        let K = params[1]
        let A = params[2]
        
        let xDot: [Double] = [r*N*(N/A - 1)*(1 - N/K)]
        return xDot
    }
}
