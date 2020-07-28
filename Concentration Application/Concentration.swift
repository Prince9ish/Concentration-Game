//
//  Concentration.swift
//  Concentration Application
//
//  Created by Prince Pattanayanon on 06/07/2020.
//  Copyright © 2020 CAF Industries. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var FlipCount = 0
    var Score = 0
    var OneAndOnlyFaceCardIndex : Int?
    
    init(numberOfCardsPairs: Int){
        for _ in 1...numberOfCardsPairs{
            let card = Card()
            cards += [card,card]
        }
        // TODO : Shuffle Cards
        cards.shuffle()
    }
    
    func chooseCard(at index: Int){
        FlipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = OneAndOnlyFaceCardIndex, matchIndex != index {
                if cards[matchIndex].identifer == cards[index].identifer {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    Score += 2
                }
                cards[index].isFaceUp = true
                OneAndOnlyFaceCardIndex = nil
        }else{
            // Either No Cards Or Two Cards Faced Up
            for turnDownIndex in cards.indices {
                cards[turnDownIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            OneAndOnlyFaceCardIndex = index
            Score += cards[index].isSeen ? -1 : 0
        }
    }
    cards[index].isSeen = true
    }
    
}
