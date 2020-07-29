//
//  SuffixView.swift
//  Fourier
//
//  Created by Tanay Nistala on 6/28/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct SuffixView: View {
    @State var type: Int = 1
    @State var vars: Int = 0
    @State var coefficient: Int = 0
    
    @State var list = [
        [
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
            },
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("2")
                    .font(.footnote)
                    .baselineOffset(-2)
            },
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("3")
                    .font(.footnote)
                    .baselineOffset(-2)
            },
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("4")
                    .font(.footnote)
                    .baselineOffset(-2)
            }
        ],
        [
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
            },
            Group {
                Text("f ").italic()
                    +
                Text("y")
                    .font(.footnote)
                    .baselineOffset(-6)
            },
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("2")
                    .font(.footnote)
                    .baselineOffset(-2)
            },
            Group {
                Text("f ").italic()
                    +
                Text("xy")
                    .font(.footnote)
                    .baselineOffset(-6)
            },
            Group {
                Text("f ").italic()
                    +
                Text("y")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("2")
                    .font(.footnote)
                    .baselineOffset(-2)
            },
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("3")
                    .font(.footnote)
                    .baselineOffset(-2)
            },
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("2")
                    .font(.footnote)
                    .baselineOffset(-2)
                +
                Text("y")
                    .font(.footnote)
                    .baselineOffset(-6)
            },
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("y")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("2")
                    .font(.footnote)
                    .baselineOffset(-2)
            },
            Group {
                Text("f ").italic()
                    +
                Text("y")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("3")
                    .font(.footnote)
                    .baselineOffset(-2)
            },
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("4")
                    .font(.footnote)
                    .baselineOffset(-2)
            },
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("3")
                    .font(.footnote)
                    .baselineOffset(-2)
                +
                Text("y")
                    .font(.footnote)
                    .baselineOffset(-6)
            },
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("2")
                    .font(.footnote)
                    .baselineOffset(-2)
                +
                Text("y")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("2")
                    .font(.footnote)
                    .baselineOffset(-2)
            },
            Group {
                Text("f ").italic()
                    +
                Text("x")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("y")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("3")
                    .font(.footnote)
                    .baselineOffset(-2)
            },
            Group {
                Text("f ").italic()
                    +
                Text("y")
                    .font(.footnote)
                    .baselineOffset(-6)
                +
                Text("4")
                    .font(.footnote)
                    .baselineOffset(-2)
            }
        ]
    ]
    
    var body: some View {
        Group {
            if type == 1 {
                Group {
                    Text("f ").italic()
                        +
                    Text("(\(coefficient))")
                        .font(.footnote)
                        .baselineOffset(6.0)
                }
                .font(Font.system(.body, design: .serif))
            } else {
                list[vars][coefficient]
                    .font(Font.system(.body, design: .serif))
            }
        }
    }
}
