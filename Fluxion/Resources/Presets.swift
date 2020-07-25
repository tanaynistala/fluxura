//
//  PresetData.swift
//  Fluxion
//
//  Created by Tanay Nistala on 7/11/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

class Presets {
    let presets: [Preset] = [
        Preset(
            id: 1,
            name: "Lotka-Volterra",
            subject: .biology,
            order: 1,
            types: [.nonlinear, .hetero],
            description: "The Lotka–Volterra equations, also known as the predator–prey equations, are a pair of first-order nonlinear differential equations, frequently used to describe the dynamics of biological systems in which two species interact, one as a predator and the other as prey.",
            url: "https://en.wikipedia.org/wiki/Lotka-Volterra_equations",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 2,
            name: "Rate Equation",
            subject: .chemistry,
            order: -1,
            types: [.pde],
            description: "The rate law or rate equation for a chemical reaction is a differential equation that links the reaction rate with concentrations or pressures of reactants and constant parameters (normally rate coefficients and partial reaction orders). To determine the rate equation for a particular system one combines the reaction rate with a mass balance for the system.",
            url: "https://en.wikipedia.org/wiki/Rate_equation",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 3,
            name: "Heat Equation",
            subject: .physics,
            order: 1,
            types: [.linear, .pde, .homo],
            description: "In physics and mathematics, the heat equation is a partial differential equation that describes how the distribution of some quantity (such as heat) evolves over time in a solid medium, as it spontaneously flows from places where it is higher towards places where it is lower. It is a special case of the diffusion equation.",
            url: "https://en.wikipedia.org/wiki/Heat_Equation",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 4,
            name: "Navier-Stokes",
            subject: .physics,
            order: -1,
            types: [.nonlinear, .ode, .hetero],
            description: "The Navier–Stokes equations are a set of differential equations which describe the motion of viscous fluid substances. These balance equations arise from applying Isaac Newton's second law to fluid motion, together with the assumption that the stress in the fluid is the sum of a diffusing viscous term (proportional to the gradient of velocity) and a pressure term—hence describing viscous flow.",
            url: "https://en.wikipedia.org/wiki/Navier-Stokes_equations",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 5,
            name: "Euler-Lagrange",
            subject: .physics,
            order: 2,
            types: [.pde],
            description: "In the calculus of variations, the Euler equation is a second-order partial differential equation whose solutions are the functions for which a given functional is stationary. Because a differentiable functional is stationary at its local extrema, the Euler–Lagrange equation is useful for solving optimization problems in which, given some functional, one seeks the function minimizing or maximizing it. This is analogous to Fermat's theorem in calculus, stating that at any point where a differentiable function attains a local extremum its derivative is zero.",
            url: "https://en.wikipedia.org/wiki/Euler-Lagrange_equation",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 6,
            name: "Eikonal",
            subject: .physics,
            order: -1,
            types: [.nonlinear, .pde],
            description: "The eikonal equation is a non-linear partial differential equation encountered in problems of wave propagation, when the wave equation is approximated using the WKB theory. It is derivable from Maxwell's equations of electromagnetics, and provides a link between physical (wave) optics and geometric (ray) optics.",
            url: "https://en.wikipedia.org/wiki/Eikonal_equation",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 7,
            name: "Korteweg-de Vries",
            subject: .physics,
            order: -1,
            types: [.nonlinear, .pde],
            description: "In mathematics, the Korteweg–de Vries (KdV) equation is a mathematical model of waves on shallow water surfaces. It is particularly notable as the prototypical example of an exactly solvable model, that is, a non-linear partial differential equation whose solutions can be exactly and precisely specified. KdV can be solved by means of the inverse scattering transform.",
            url: "https://en.wikipedia.org/wiki/Korteweg-de_Vries_equation",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 8,
            name: "Laplace",
            subject: .physics,
            order: 1,
            types: [.pde],
            description: "In mathematics and physics, Laplace's equation is a second-order partial differential equation named after Pierre-Simon Laplace who first studied its properties.",
            url: "https://en.wikipedia.org/wiki/Laplace%27s_equation",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 9,
            name: "Lorenz System",
            subject: .physics,
            order: -1,
            types: [.ode],
            description: "The Lorenz system is a system of ordinary differential equations first studied by Edward Lorenz. It is notable for having chaotic solutions for certain parameter values and initial conditions. In particular, the Lorenz attractor is a set of chaotic solutions of the Lorenz system.",
            url: "https://en.wikipedia.org/wiki/Lorenz_attractor",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 10,
            name: "Poisson",
            subject: .physics,
            order: -1,
            types: [.pde],
            description: "Poisson's equation is an elliptic partial differential equation of broad utility theoretical physics. For example, the solution to Poisson's equation the potential field caused by a given electric charge or mass density distribution; with the potential field known, one can then calculate electrostatic or gravitational (force) field. It is a generalization of Laplace's equation, which is also frequently seen in physics.",
            url: "https://en.wikipedia.org/wiki/Poisson%27s_equation",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 11,
            name: "Poisson-Boltzmann",
            subject: .physics,
            order: 2,
            types: [.pde],
            description: "The Poisson–Boltzmann equation is a useful equation in many settings, whether it be to understand physiological interfaces, polymer science, electron interactions in a semiconductor, or more. It aims to describe the distribution of the electric potential in solution in the direction normal to a charged surface. This distribution is important to determine how the electrostatic interactions will affect the molecules in solution. The Poisson–Boltzmann equation is derived via mean-field assumptions.",
            url: "https://en.wikipedia.org/wiki/Poisson-Boltzmann_equation",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 12,
            name: "Wave Equatiom",
            subject: .physics,
            order: 2,
            types: [.linear, .pde],
            description: "The wave equation is an important second-order linear partial differential equation for the description of waves—as they occur in classical physics—such as mechanical waves (e.g. water waves, sound waves and seismic waves) or light waves. It arises in fields like acoustics, electromagnetics, and fluid dynamics.",
            url: "https://en.wikipedia.org/wiki/Wave_equation",
            model: LotkaVolterra(),
            parameters: ["Parameter 1", "Parameter 2"],
            coefficients: ["Input 1", "Input 2"]
        ),
        Preset(
            id: 13,
            name: "Swinging Atwood's Machine", // This is probably not an SAM
            subject: .physics,
            order: 2,
            types: [.ode],
            description: "The swinging Atwood's machine (SAM) is a mechanism that resembles a simple Atwood's machine except that one of the masses is allowed to swing in a two-dimensional plane, producing a dynamical system that is chaotic for some system parameters and initial conditions. Specifically, it comprises two masses connected by an inextensible, massless string suspended on two frictionless pulleys of zero radius such that the pendulum can swing freely around its pulley without colliding with the counterweight.",
            url: "https://en.wikipedia.org/wiki/Swinging_Atwood%27s_machine",
            model: Pendulum(),
            parameters: ["Gravity"],
            coefficients: ["r", "θ"]
        )
    ]
}
