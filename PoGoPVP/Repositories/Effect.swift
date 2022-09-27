//
//  Effect.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 25/09/2022.
//

import Foundation

enum Effect : Int, CustomStringConvertible {
    case noEffect=0
    case notVeryEffective
    case normalEffect
    case superEffective
    
    var description: String {
        switch self{
        case .noEffect:         return "No Effect"
        case .notVeryEffective: return "Not Very Effective"
        case .normalEffect:     return "Normal Effect"
        case .superEffective:   return "Super Effective"
        }
    }
    
    static var patterns: [String : Effect] = [
//        Effect.noEffect.description:         .noEffect,
//        Effect.notVeryEffective.description: .notVeryEffective,
//        Effect.normalEffect.description:     .normalEffect,
//        Effect.superEffective.description:   .superEffective,
        "noeffect":                          .noEffect,
        "notveryeffective":                  .notVeryEffective,
        "normaleffect":                      .normalEffect,
        "supereffective":                    .superEffective
    ]
    
    func stringFromEffect( ) -> String{
        return self.description
    }
}

extension String{
    func effectFromString()->Effect?{
        var s = self.lowercased()
        s = s.replacingOccurrences(of: " ", with: "")
        return Effect.patterns[s]
    }
}

