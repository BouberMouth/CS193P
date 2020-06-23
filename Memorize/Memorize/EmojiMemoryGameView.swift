//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Antoine on 22/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(emojiMemoryGame.cards) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        self.emojiMemoryGame.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.strokeLineWidth)
                Text(self.card.content)
            } else {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill()
            }
        }.font(self.font(forSize: size))
    }
    
    
    //MARK: - View Constants
    
    let cornerRadius: CGFloat = 10.0
    let strokeLineWidth: CGFloat = 3.0
    
    func font(forSize size: CGSize) -> Font {
        Font.system(size: min(size.height, size.width) * 0.75)
    }
    
    
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiMemoryGame: EmojiMemoryGame())
    }
}
