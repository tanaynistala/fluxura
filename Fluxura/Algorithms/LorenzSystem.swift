//
//  LorenzAttractor.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/6/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

extension Solver {
    func LorenzSystem(t: Double, x: [Double], params: [Double]) -> [Double] {
        let sigma = params[0]
        let rho = params[1]
        let beta = params[2]
        
        let xDot: [Double] = [sigma*(x[1]-x[0]), x[0]*(rho-x[2])-x[1], x[0]*x[1] - beta*x[2]]
        return xDot
    }
}
