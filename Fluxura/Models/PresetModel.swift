/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual landmark.
*/

import SwiftUI
import Combine

struct Preset {
    var id = UUID()
    var name: String
    var subject: Subject
    var order: Int
    var types: [Category]
    var description: String
    var url: String
    
    // Remove these if using JSON parsing
    var model: (_ t: Double, _ x: [Double], _ params: [Double]) -> [Double]
    var parameters: [String]
    var initial: [String]
    
    var inputDescription: [[String]]

    enum Subject: String, CaseIterable, Codable, Hashable {
        case all = "All"
//        case favorites = "Favorites"
        case physics = "Physics"
        case biology = "Biology"
        case chemistry = "Chemistry"
        case cs = "Computer Science"
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

