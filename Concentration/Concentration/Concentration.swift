//
//  Concentration.swift
//  Concentration
//
//  Created by litchi on 1/10/19.
//  Copyright © 2019 Stella. All rights reserved.
//

import Foundation

struct Concentration
{
    var cards = [Card]()
    
    private(set) var indexOfOneAndOnlyFaceUpCard: Int? {
        //get
        get {
            //let ch = "hello".oneAndOnly
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            //return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        
        //set
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
