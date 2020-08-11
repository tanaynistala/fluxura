//
//  LotkaVolterra.swift
//  Fluxura
//
//  Created by Tanay Nistala on 7/9/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

extension Solver {
    func LotkaVoltera(t: Double, x: [Double], params: [Double]) -> [Double] {
        let alpha = params[0]
        let beta = params[1]
        let gamma = params[2]
        let delta = params[3]
        
        let xDot: [Double] = [alpha*x[0] - beta*x[0]*x[1], delta*x[0]*x[1] - gamma*x[1]]
        return xDot
    }
}
