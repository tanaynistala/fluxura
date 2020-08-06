//
//  FluidResistance3D.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/6/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

extension Solver {
    func FluidResistance3D(t: Double, x: [Double], params: [Double]) -> [Double] {
        let mass = params[0]
        let rho = params[1]
        let eta = params[2]
        let a = params[3]
        let c = params[3]
        let r = params[4]
        let g = 9.81
        
        let v = sqrt(pow(x[1], 2) + pow(x[3], 2) + pow(x[5], 2))
        
        let aX = (1 / (2 * mass)) * ((-rho * pow(v, 2) * c * a) - (12 * .pi * eta * r * v))
        let aY = (1 / (2 * mass)) * ((-rho * pow(v, 2) * c * a) - (12 * .pi * eta * r * v))
        let aZ = -g + (1 / (2 * mass)) * ((-rho * pow(v, 2) * c * a) - (12 * .pi * eta * r * v))
        
        let xDot: [Double] = [x[1], aX, x[3], aY, x[5], aZ]
        return xDot
    }
}
