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
        VStack {
            HStack {
                Text(EmojiMemoryGame.theme.rawValue.capitalized)
                Spacer()
                Text(emojiMemoryGame.score)
            }
            .foregroundColor(EmojiMemoryGame.theme.tint)
            .font(Font.system(.title, design: .rounded))
            .padding(.horizontal)
            
            ZStack {
                Grid(emojiMemoryGame.cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                self.emojiMemoryGame.choose(card: card)
                            }
                    }
                    .padding(5)
                }
                .foregroundColor(EmojiMemoryGame.theme.tint)
                .padding()
                
                Group {
                    Capsule().fill(Color.black)
                    Text("GAME OVER !")
                        .font(Font.system(.largeTitle, design: .rounded))
                        .foregroundColor(.white)
                        
                }   .frame(height: 100.0)
                    .padding(.horizontal, 30.0)
                    .opacity(emojiMemoryGame.isTimeUp ? 1 : 0)
                    .animation(.easeInOut(duration: 0.75))
            }
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.emojiMemoryGame.newGame()
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(EmojiMemoryGame.theme.tint)
                    Text("New Game")
                        .foregroundColor(.white)
                        .font(Font.system(.title, design: .rounded))
                }
                .frame(maxWidth: .infinity, maxHeight: 50.0)
                .padding()
            })

            
        }

    }
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0 - 90.0), endAngle: Angle.degrees(-360.0 * animatedBonusRemaining  - 90.0))
                            .onAppear() {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0 - 90.0), endAngle: Angle.degrees(-360.0 * card.bonusRemaining  - 90.0))
                    }
                }
                    .padding(5)
                    .opacity(0.4)
                Text(self.card.content)
                    .font(self.font(forSize: size))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360.0 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
                .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.offset(x: -1000, y: 0))
            
        }
    }
    
    
    //MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let strokeLineWidth: CGFloat = 3.0
    private func font(forSize size: CGSize) -> Font {
        Font.system(size: min(size.height, size.width) * 0.6)
    }
    
    
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiMemoryGame: EmojiMemoryGame())
    }
}
