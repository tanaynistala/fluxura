//
//  RateEquation.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/6/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

extension Solver {
    func RateEquation(t: Double, x: [Double], params: [Double]) -> [Double] {
        let a = params[0]
        let b = params[1]
        let c = params[2]
        let d = params[3]
        
        let k = params[4]
        let m = params[5]
        let n = params[6]
        
        let rate = k * pow(x[0], m) * pow(x[1], n)
        
        let xDot: [Double] = [(-rate/a), (-rate/b), (rate/c), (rate/d)]
        return xDot
    }
}
