//
//  SetVM.swift
//  Set Game
//
//  Created by Antoine on 26/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import SwiftUI

class SetVM: ObservableObject {
    
    @Published var setGame: SetGame = SetVM.createNewGame()
    
    private static func createNewGame() -> SetGame {
        return SetGame()
    }
    
    var cards: [SetGame.Card] {
        setGame.cards
    }
    var availableCards: [SetGame.Card] {
        setGame.displayedCards
    }
    var isDeckEmpty: Bool {setGame.isDeckEmpty}
    var thereIsAMatch: Bool {setGame.thereIsAMatch}
    var thereIsAMismatch: Bool {setGame.thereIsAMismatch}
    
    var gameHasStarted: Bool {
        return availableCards.count != 0
    }
    
    //MARK: - Intents:
    
    func select(_ card: SetGame.Card) {
        setGame.select(card)
    }
    
    func dealThreeCards() {
        setGame.deal(3)
    }
    
    func newGame() {
        setGame = SetVM.createNewGame()
    }
    
    func startPlaying() {
        setGame.deal(12)
    }

    static func colorFor(_ card: SetGame.Card) -> Color {
        switch card.color {
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        case .red:
            return Color.red
        }
    }
    
    static func viewForCard(card: SetGame.Card) -> some View {
        var strings = [String]()
        switch card.fill {
        case .empty:
            switch card.shape {
            case .circle:
                strings = ["○"]
            case .square:
                strings = ["□"]
            case .triangle:
                strings = ["△"]
            }
            
        case .filled:
            switch card.shape {
            case .circle:
                strings = ["●"]
            case .square:
                strings = ["■"]
            case .triangle:
                strings = ["▲"]
            }
            
        case .zebra:
            switch card.shape {
            case .circle:
                strings = ["●", "○"]
            case .square:
                strings = ["■", "□"]
            case .triangle:
                strings = ["▲", "△"]
            }
        }
        
        return ZStack {
            Text(strings[0]).opacity(strings.count == 2 ? 0.3 : 1)
            if strings.count == 2 {
                Text(strings[1])
            }
        }
    }
}
