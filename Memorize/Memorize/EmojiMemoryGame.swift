//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Antoine on 23/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGame: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    var isGameOver: Bool {
        memoryGame.isGameOver
    }
    
    var isTimeUp: Bool {
        memoryGame.isTimeUp
    }
    
    var score: String {
        return String(memoryGame.score)
    }
    
    static var theme: Theme = .halloween
    
    private static func createMemoryGame() -> MemoryGame<String> {
        theme = Theme.allCases.randomElement()!
        let numberOfPairs = Int.random(in: 2...theme.emojiSet.count)
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { index in
            theme.emojiSet[index]
        }
    }
    
    var cards: [MemoryGame<String>.Card] {
        memoryGame.cards
    }
    
    //MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        memoryGame.choose(card: card)
        if isGameOver {
            newGame()
        }
    }
    
    func newGame() {
        memoryGame = EmojiMemoryGame.createMemoryGame()
    }
    
    
    enum Theme: String, CaseIterable {
        case halloween
        case faces
        case fruits
        case sports
        case animals
        case flags
        
        var emojiSet: [String] {
            switch self {
            case .halloween:
                return "👻.🎃.🕷.🕸.👹".components(separatedBy: ["."])
            case .faces:
                return "😂.🥰.😜.😇.😭".components(separatedBy: ["."])
            case .fruits:
                return "🍎.🍒.🍌.🥝.🍇".components(separatedBy: ["."])
            case .sports:
                return "⚽️.🏀.🏈.🎾.🎱".components(separatedBy: ["."])
            case .animals:
                return "🐶.🐱.🦊.🐯.🐷.🙊.🦁.🐮.🐔.🦉.🐗".components(separatedBy: ["."])
            case .flags:
                return "🇪🇸.🇺🇸.🇫🇷.🇮🇳.🇨🇳.🇯🇵.🇮🇹".components(separatedBy: ["."])
            }
        }
        
        var tint: Color {
            switch self {
            case .halloween:
                return .orange
            case .faces:
                return .yellow
            case .fruits:
                return .green
            case .sports:
                return .blue
            case .animals:
                return .red
            case .flags:
                return .gray
            }
        }
    }
}




