//
//  HarmonicMotion.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/6/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

extension Solver {
    func SimpleHarmonic(t: Double, x: [Double], params: [Double]) -> [Double] {
        let k = params[0]
        
        let xDot: [Double] = [x[1], -k*x[0]]
        return xDot
    }
    
    func DampedHarmonic(t: Double, x: [Double], params: [Double]) -> [Double] {
        let a = params[0]
        let k = params[1]
        
        let xDot: [Double] = [x[1], (-k*x[0]) - (a*x[1])]
        return xDot
    }
    
    func SinusoidalDriving(t: Double, x: [Double], params: [Double]) -> [Double] {
        let a = params[0]
        let k = params[1]
        let f0 = params[2]
        let omega = params[3]
        
        let xDot: [Double] = [x[1], (f0 * sin(omega * t)) - (k*x[0]) - (a * x[1])]
        return xDot
    }
}
