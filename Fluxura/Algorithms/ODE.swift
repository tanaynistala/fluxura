//
//  ODE.swift
//  Fluxura
//
//  Created by Tanay Nistala on 7/22/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

extension Solver {
    func ODEModel1(t: Double, x: [Double], params: [Double]) -> [Double] {
        let xDot: [Double] = [
            params[0]*x[0] + params[1]
        ]
        return xDot
    }
    
    func ODEModel2(t: Double, x: [Double], params: [Double]) -> [Double] {
        let xDot: [Double] = [
            x[1],
            (params[0]*x[1] + params[1]*x[0] + params[2])
        ]
        return xDot
    }
    
    func ODEModel3(t: Double, x: [Double], params: [Double]) -> [Double] {
        let xDot: [Double] = [
            x[1],
            x[2],
            (params[0]*x[2] + params[1]*x[1] + params[2]*x[0] + params[3])
        ]
        return xDot
    }
    
    func ODEModel4(t: Double, x: [Double], params: [Double]) -> [Double] {
        let xDot: [Double] = [
            x[1],
            x[2],
            x[3],
            (params[0]*x[3] + params[1]*x[2] + params[2]*x[1] + params[3]*x[0] + params[4])
        ]
        return xDot
    }
}
