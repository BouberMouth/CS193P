//
//  SetGameView.swift
//  Set Game
//
//  Created by Antoine on 26/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var viewModel = SetVM()
    
    var body: some View {
        VStack {
            Grid(viewModel.availableCards) { card in
                SetCardView(card: card, isMismatched: self.viewModel.thereIsAMismatch, isMatched: self.viewModel.thereIsAMatch)
                    .cardify(isFaceUp: true)
                    .opacity(card.isMatched ? 0 : 1)
                    .padding(3)
                    .animation(.easeInOut(duration: 0.7))
                    .transition(.offset(CGSize(width: -1000, height: 0)))
                    .aspectRatio(0.7, contentMode: .fit)
                    .onTapGesture {
                        self.viewModel.select(card)
                }
            }
            
            Button(action: {
                self.viewModel.dealThreeCards()
            }, label: {
                Text("Deal 3 cards")
                    .foregroundColor(.red)
                    .opacity(viewModel.isDeckEmpty ? 0 : 1)
            })
        }
    }
}

struct SetCardView: View {
    var card: SetGame.Card
    var isMismatched: Bool
    var isMatched: Bool
    
    var background: Color {
        if isMismatched {
            return .red
        } else if isMatched {
            return .green
        }
        return .blue
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if !card.isMatched && card.hasBeenDealt {
            ZStack {
                RoundedRectangle(cornerRadius: 5).fill(background)
                    .opacity(card.isSelected ? 0.2 : 0)
                VStack {
                    ForEach(0..<card.number) { _ in
                        SetVM.viewForCard(card: self.card)
                            .foregroundColor(SetVM.colorFor(self.card))
                            .font(self.font(forSize: size))
                            .padding(0)
                    }
                }
            }
            .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            .transition(AnyTransition.offset(x: -1000, y: 0))
        }
    }
    
    private func font(forSize size: CGSize) -> Font {
        Font.system(size: size.height * 0.15)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}


