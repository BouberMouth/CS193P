//
//  Set.swift
//  Set Game
//
//  Created by Antoine on 26/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import Foundation

struct SetGame {
    
    private(set) var cards: [Card]
    
    init() {
        cards = [Card]()
        var id = 0
        for a in 1...3 {
            for b in 1...3 {
                for c in 1...3 {
                    for d in 1...3 {
                        cards.append(Card(
                            id: id,
                            shape: SetShape.init(rawValue: a)!,
                            number: b,
                            color: SetColor.init(rawValue: c)!,
                            fill: SetFill.init(rawValue: d)!))
                        id += 1
                    }
                }
            }
        }
    }
    
    
    struct Card: Identifiable {
        var id: Int
        var shape: SetShape
        var number: Int
        var color: SetColor
        var fill: SetFill
    }
}

enum SetShape: Int {
    case square = 1
    case triangle = 2
    case circle = 3
}

enum SetColor: Int {
    case purple = 1
    case green = 2
    case red = 3
}

enum SetFill: Int {
    case filled = 1
    case empty = 2
    case zebra = 3
}
