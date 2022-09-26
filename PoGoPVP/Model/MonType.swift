//
//  MonType.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 25/09/2022.
//


import Foundation
enum MonType : Int, CustomStringConvertible {
    case normal=0
    case fire
    case water
    case electric
    case grass
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dragon
    case dark
    case steel
    case fairy
    
    var description: String {
        switch self{
        case .normal:   return "Normal"
        case .fire:     return "Fire"
        case .water:    return "Water"
        case .electric: return "Electric"
        case .grass:    return "Grass"
        case .ice:      return "Ice"
        case .fighting: return "Fighting"
        case .poison:   return "Poison"
        case .ground:   return "Ground"
        case .flying:   return "Flying"
        case .psychic:  return "Psychic"
        case .bug:      return "Bug"
        case .rock:     return "Rock"
        case .ghost:    return "Ghost"
        case .dragon:   return "Dragon"
        case .dark:     return "Dark"
        case .steel:    return "Steel"
        case .fairy:    return "Fairy"
        }
    }
    
    static var patterns: [String : MonType] = [
        "normal":       .normal,
        "fire":         .fire,
        "water":        .water,
        "electric":     .electric,
        "grass":        .grass,
        "ice":          .ice,
        "fighting":     .fighting,
        "poison":       .poison,
        "ground":       .ground,
        "flying":       .flying,
        "psychic":      .psychic,
        "bug":          .bug,
        "rock":         .rock,
        "ghost":        .ghost,
        "dragon":       .dragon,
        "dark":         .dark,
        "steel":        .steel,
        "fairy":        .fairy
    ]
    
    func stringFromMonType( ) -> String{
        return self.description
    }
}

extension String{
    func monTypeFromString()->MonType?{
        var s = self.lowercased()
        s = s.replacingOccurrences(of: " ", with: "")
        return MonType.patterns[s]
    }
}

