//
//  MemoryGame.swift
//  Memorize
//
//  Created by Antoine on 23/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: [Card]
    
    var isGameOver: Bool {
        cards.filter { $0.isMatched }.count == cards.count
    }
    
    var isTimeUp: Bool {
        cards.filter { $0.bonusRemaining == 0 }.count != 0
    }
    
    var indexOfTheOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for i in cards.indices {
                cards[i].isFaceUp = i == newValue
            }
        }
    }
    
    var score: Int = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for index in 0..<numberOfPairsOfCards {
            cards.append(Card(id: index*2, content: cardContentFactory(index)))
            cards.append(Card(id: index*2+1, content: cardContentFactory(index)))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        if !isTimeUp, let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    score += 2
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                } else {
                    if cards[chosenIndex].hasBeenSeen {
                        score -= 1
                    } else {
                        cards[chosenIndex].hasBeenSeen = true
                    }
                    if cards[potentialMatchIndex].hasBeenSeen {
                        score -= 1
                    } else {
                        cards[potentialMatchIndex].hasBeenSeen = true
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
        }
        
        
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var hasBeenSeen: Bool = false
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        
        
        
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
    
    
    
    
    
    
    
}
