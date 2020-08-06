//
//  DoublePendulum.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/5/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

// INPUT: x = [ r, rDot, theta, thetaDot ]
// OUTPUT: xDot = [ rDot, rDotDot, thetaDot, thetaDotDot ] = [ x[1], d/dx(x[1]), x[3], d/dx(x[3]) ]

extension Solver {
    func DoublePendulum(t: Double, x: [Double], params: [Double]) -> [Double] {
        let g = params[4]
        
        let l1 = params[0]
        let l2 = params[1]
        let m1 = params[2]
        let m2 = params[3]
        
        let alpha1 = (l2/l1)*(m2/(m1+m2)) * cos(x[0] - x[2])
        let alpha2 = (l1/l2) * cos(x[0] - x[2])
        let f1 = -1 * ((l2/l1) * (m2/(m1+m2)) * pow(x[3], 2) * sin(x[0] - x[2]) + (g/l2) * sin(x[0]))
        let f2 = (l1/l2) * pow(x[0], 2) * sin(x[0] - x[2]) - (g/l2) * sin(x[3])
        
        let xDot = [x[1], (f1 - (alpha1 * f2))/(1 - (alpha1 * alpha2)), x[3], (f2 - (alpha2 * f1))/(1 - (alpha1 * alpha2))]
    
        return xDot
    }
}

