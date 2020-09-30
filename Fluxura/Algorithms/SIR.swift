//
//  SIR.swift
//  Fluxura
//
//  Created by Tanay Nistala on 8/7/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

extension Solver {
    func SIR(t: Double, x: [Double], params: [Double]) -> [Double] {
        let beta = params[0]
        let gamma = params[1]
        let delta = params[2]
        let mu = params[3]
        let N = x[0] + x[1] + x[2]
        
        let xDot: [Double] = [delta - mu*x[0] - beta*x[1]*x[0]/N, beta*x[1]*x[0]/N - gamma*x[1] - mu*x[1], gamma*x[1] - mu*x[2]]
        return xDot
    }
}
