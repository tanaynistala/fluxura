//
//  Pendulum.swift
//  Fluxura
//
//  Created by Tanay Nistala on 7/9/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

// INPUT: x = [ r, rDot, theta, thetaDot ]
// OUTPUT: xDot = [ rDot, rDotDot, thetaDot, thetaDotDot ] = [ x[1], d/dx(x[1]), x[3], d/dx(x[3]) ]

class Pendulum: Solver {
    func Pendulum(t: Double, x: [Double], params: [Double]) -> [Double] {
        let g = 9.81
        
        let rDotDot = ( x[0] * x[2] * x[2] ) - g * ( 1 - cos(x[2]) )
        let thetaDotDot = -1 * ( ( 2 * x[1] * x[3] ) + ( g * sin(x[0]) ) ) / x[0]
        
        let xDot = [x[1], rDotDot, x[3], thetaDotDot]
    
        return xDot
    }
}
