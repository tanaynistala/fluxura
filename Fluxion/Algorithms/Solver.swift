//
//  RungeKutta.swift
//  Fluxion
//
//  Created by Tanay Nistala on 6/16/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation

class Solver: ObservableObject {
    func RungeKutta(model: (_ t: Double, _ x: [Double], _ params: [Double]) -> [Double], x0: [Double], t: [Double], params: [Double]) -> ([Double], [[Double]]) {
        
        // Create timestamps array
        var timestamps = [Double]()
        var currentT = t[0]
        while currentT < t[1] {
            timestamps.append(currentT)
            currentT += t[2]
        }
        
        // Get number of intervals and variables, initialize main array
        let intervals = timestamps.count
        let varCount = x0.count
        var x = Array(repeating: Array(repeating: 0.0, count: varCount), count: intervals)
        x[0] = x0
        
        // Iterate over every interval
        for k in 0..<intervals-1 {
            let k1 = model(timestamps[k], x[k], params).map {$0 * t[2]}
            
            var k15 = [Double]()
            for index in 0..<x[k].count {
                k15.append(x[k][index] + k1[index]/2)
            }
            let k2 = model(timestamps[k] + t[2]/2, k15, params).map {$0 * t[2]}
            
            var k25 = [Double]()
            for index in 0..<x[k].count {
                k25.append(x[k][index] + k2[index]/2)
            }
            let k3 = model(timestamps[k] + t[2], k25, params).map {$0 * t[2]}
            
            var k35 = [Double]()
            for index in 0..<x[k].count {
                k35.append(x[k][index] + k1[index])
            }
            let k4 = model(timestamps[k] + t[2]/2, k35, params).map {$0 * t[2]}
            
            // calculate dx for each index within k1...4 and use it to create x[k+1]
            for index in 0..<k1.count {
                let dx = (k1[index] + 2*k2[index] + 2*k3[index] + k4[index])/6
                x[k+1][index] = x[k][index] + dx
            }
        }
        
        // return timestamps and x
        return (timestamps, x)
    }
}
