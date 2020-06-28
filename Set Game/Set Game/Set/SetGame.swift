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
    
    
    
    private var indexOfAvailableCards = [Int]()
    var availableCards: [Card] {
        return indexOfAvailableCards.map { cards[$0] }
    }
    
    private var indexesOfSelectedCards: [Int] {
        selectedCards.map { cards.firstIndex(matching: $0)! }
    }
    private var selectedCards: [Card] {
        cards.filter { $0.isSelected }
    }
    
    private var dealCount = 0
    var isDeckEmpty: Bool {
        return dealCount == cards.count
    }
    
    var thereIsAMatch: Bool {
        if selectedCards.count == 3 {
            
            var pattern = [0, 0, 0, 0]
            selectedCards.forEach { item in
                pattern[0] += item.color.rawValue
                pattern[1] += item.fill.rawValue
                pattern[2] += item.number
                pattern[3] += item.shape.rawValue
            }
            
            if pattern.filter({ $0 % 3 != 0 }).count == 0 {
                return true
            }
        }
        return false
    }
    
    var thereIsAMismatch: Bool {
        !thereIsAMatch && selectedCards.count == 3
    }
    
    // Initializes the game with the 81 cards each with a different pattern, then shuffle and deal 12 of them.
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
        cards.shuffle()
        deal(12)
    }
    
    
    // Deals the specified amount of cards. If a position is specified, the card replaces the older one in the
    // array.
    // ㊟ A position may be specified if and only if the number of card to be dealt is 1 !!!
    mutating func deal(_ n: Int, at position: Int? = nil) {
        indexesOfSelectedCards.forEach {
            cards[$0].isSelected = false
        }
        
        let indexOfCardsToDeal = cards.filter { $0.hasBeenDealt == false }
            .map { cards.firstIndex(matching: $0)! }
            .shuffled()
        
        guard indexOfCardsToDeal.count >= n else {
            if let position = position {
                indexOfAvailableCards.remove(at: position)
            }
            return
        }
        
        for i in 0..<n {
            cards[indexOfCardsToDeal[i]].hasBeenDealt = true
            if let position = position {
                guard n == 1 else {
                    fatalError("••• BAD USAGE OF SetGame.deal(n: at:) FUNCTION: A POSITION MAY BE SPECIFIED IF AND ONLY IF THE NUMBER OF CARD TO BE DEALT IS 1 !!! •••")
                }
                indexOfAvailableCards[position] = indexOfCardsToDeal[i]
            } else {
                indexOfAvailableCards.append(indexOfCardsToDeal[i])
            }
        }
        
        dealCount += n
    }
    
    
    // Selects a card and handle the matching if there are 3 cards selected
    mutating func select(_ card: Card) {
        if selectedCards.count == 3 {
            let foundAMatch = thereIsAMatch
            for index in indexesOfSelectedCards {
                if foundAMatch {
                    cards[index].isMatched = true
                    deal(1, at: indexOfAvailableCards.firstIndex(of: index)!)
                }
                cards[index].isSelected = false
            }
        }
        
        let indexOfChosenCard = cards.firstIndex(matching: card)!
        if indexesOfSelectedCards.contains(indexOfChosenCard) {
            cards[indexOfChosenCard].isSelected = false
        } else {
            cards[indexOfChosenCard].isSelected = true
        }
        
    }
    
    
    struct Card: Identifiable {
        var id: Int
        var shape: SetShape
        var number: Int
        var color: SetColor
        var fill: SetFill
        var value: Int {
            return shape.rawValue + number + color.rawValue + fill.rawValue
        }
        
        var hasBeenDealt: Bool = false
        var isSelected: Bool = false
        var isMatched: Bool = false
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
}


