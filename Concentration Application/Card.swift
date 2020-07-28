//
//  Card.swift
//  Concentration Application
//
//  Created by Prince Pattanayanon on 06/07/2020.
//  Copyright © 2020 CAF Industries. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    
    var identifer: Int
    static var uniqueIdentifer = 0
    
    static func generateUniqueIdentifer() -> Int {
        uniqueIdentifer += 1
        return uniqueIdentifer
    }
    
    init(){
        identifer = Card.generateUniqueIdentifer()
    }
    
}
