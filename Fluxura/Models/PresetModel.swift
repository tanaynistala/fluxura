/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual landmark.
*/

import SwiftUI

struct Preset {
    var id = UUID()
    var name: String
    var subject: Subject
    var order: Int
    var types: [Category]
    var description: String
    var url: String
    
    var model: (_ t: Double, _ x: [Double], _ params: [Double]) -> [Double]
    var parameters: [(String, Bool)]
    var initial: [(String, Bool)]
    
    var inputDescription: [[String]]

    enum Subject: String, CaseIterable, Codable, Hashable {
        case all = "All"
        case physics = "Physics"
        case biology = "Biology"
        case chemistry = "Chemistry"
        case economics = "Economics"
    }
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case pde = "PDE"
        case ode = "ODE"
        case homo = "Homogeneous"
        case hetero = "Heterogeneous"
        case linear = "Linear"
        case nonlinear = "Nonlinear"
    }
}

