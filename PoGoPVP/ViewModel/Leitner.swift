//
//  Leitner.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 29/06/2022.
//  Copyright © 2022 Anthony Stanners. All rights reserved.
//

import Foundation


struct LeitnerConstants {
    static let dayMin:      Int   = 1
    static let dayMax:      Int   = 64
    static let dayRange:    Range = dayMin..<dayMax+1
}

//
// An array entry of 0 is meant as a placeholder, so that the
// subarrays conform to having a fixed size of three integers.


typealias leitnerBoxesForToday = ( Int, Int, Int )

struct leitnerBoxSchedule {
    static let PLACEHOLDER = (0, 0, 0)
    static let ONE         = (1, 0, 0)
    static let TWO         = (2, 1, 0)
    static let THREE       = (3, 1, 0)
    static let FOUR        = (4, 1, 0)
    static let FIVE        = (5, 1, 0)
    static let SIX         = (6, 1, 0)
    static let SEVEN       = (7, 1, 0)
    static let FOUR_PLUS   = (4, 2, 1)
    static let SIX_PLUS    = (6, 2, 1)
    
    static let leitnerBoxes: [ leitnerBoxesForToday ] = [
        PLACEHOLDER,
        TWO,    THREE,  TWO,     FOUR,  TWO,       THREE,   TWO,    ONE,
        TWO,    THREE,  TWO,     FIVE,  FOUR_PLUS, THREE,   TWO,    ONE,
        TWO,    THREE,  TWO,     FOUR,  TWO,       THREE,   TWO,    SIX,
        TWO,    THREE,  TWO,     FIVE,  FOUR_PLUS, THREE,   TWO,    ONE,
        TWO,    THREE,  TWO,     FOUR,  TWO,       THREE,   TWO,    ONE,
        TWO,    THREE,  TWO,     FIVE,  FOUR_PLUS, THREE,   TWO,    ONE,
        TWO,    THREE,  TWO,     FOUR,  TWO,       THREE,   TWO,    SEVEN,
        TWO,    THREE,  SIX_PLUS,FIVE,  FOUR_PLUS, THREE,   TWO,    ONE
    ];
    
    func getLeitnerBoxesForToday( day: Int ) -> leitnerBoxesForToday {
        assert( LeitnerConstants.dayRange.contains(day), "Invalid day /(day) in getLeitnerBoxesForToday" )
        return leitnerBoxSchedule.leitnerBoxes[ day ]
    }
}

struct LeitnerCard{
    var xxx: Int;
// TODO: define this
}

struct LeitnerBucket{
    var bucket: Array<LeitnerCard> = Array()
    mutating func appendCard (_ card: LeitnerCard){
        bucket.append(card)
    }
}
