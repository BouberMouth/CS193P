//
//  MemoryGame.swift
//  Memorize
//
//  Created by Antoine on 23/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    
    var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for index in 0..<numberOfPairsOfCards {
            cards.append(Card(id: index*2, content: cardContentFactory(index)))
            cards.append(Card(id: index*2+1, content: cardContentFactory(index)))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
//        print(card)
        let indexOfChosenCard = index(of: card)
        cards[indexOfChosenCard].isFaceUp = !cards[indexOfChosenCard].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for i in 0..<cards.count {
            if cards[i].id == card.id {
                return i
            }
        }
        return -1
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
}
