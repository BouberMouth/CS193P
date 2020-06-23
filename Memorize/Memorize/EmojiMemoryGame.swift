//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Antoine on 23/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGame: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let content = ["👻", "🎃", "🕷", "🕸", "👹"]
        let numberOfPairs = Int.random(in: 2...content.count)
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { index in
            content[index]
        }
    }
    
    var cards: [MemoryGame<String>.Card] {
        memoryGame.cards
    }
    
    //MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        memoryGame.choose(card: card)
    }
}
