//
//  Traits.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 26/09/2022.
//

import Foundation

protocol Traits {}

struct AttackerTraits : Traits {
    var superEffectiveAgainst: [ MonType ]
    var effectiveAgainst:      [ MonType ]
    var noEffectAgainst:       [ MonType ]
    
    func getTraits ( forType: MonType ) -> AttackerTraits {
        var t = AttackerTraits( superEffectiveAgainst:[], effectiveAgainst:[], noEffectAgainst:[] )
        switch forType {
            
        case .normal:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .fire:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .water:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .electric:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .grass:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .ice:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .fighting:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .poison:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .ground:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .flying:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .psychic:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .bug:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .rock:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .ghost:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .dragon:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .dark:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .steel:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        case .fairy:
            t.superEffectiveAgainst = []
            t.effectiveAgainst = []
            t.noEffectAgainst = []
            
        }
        return t
    }
}

struct DefenderTraits : Traits {
    var weaknesses:  [ MonType ]
    var resistances: [ MonType ]
    var immunities:  [ MonType ]
    
    func getTraits( forType: MonType  ) -> DefenderTraits {
        var t = DefenderTraits( weaknesses:[], resistances:[], immunities:[] )
        switch forType {
        case .normal :
            t.resistances = []
            t.weaknesses  = [MonType.fighting]
            t.immunities  = [MonType.ghost]
            
        case .fighting:
            t.resistances = [MonType.rock, MonType.bug, MonType.dark]
            t.weaknesses = [MonType.flying, MonType.psychic, MonType.fairy]
            t.immunities = []
            
        case MonType.flying:
            t.resistances = [MonType.fighting, MonType.bug, MonType.grass]
            t.weaknesses = [MonType.rock, MonType.electric, MonType.ice]
            t.immunities = [MonType.ground]
            
        case MonType.poison:
            t.resistances = [MonType.fighting, MonType.poison, MonType.bug, MonType.fairy,MonType.grass]
            t.weaknesses = [MonType.ground, MonType.psychic]
            t.immunities = []
            
        case MonType.ground:
            t.resistances = [MonType.poison, MonType.rock]
            t.weaknesses = [MonType.water, MonType.grass, MonType.ice]
            t.immunities = [MonType.electric]
            
        case MonType.rock:
            t.resistances = [.normal, MonType.flying, MonType.poison, MonType.fire]
            t.weaknesses = [MonType.fighting, MonType.ground, MonType.steel, MonType.water, MonType.grass]
            t.immunities = []
            
        case MonType.bug:
            t.resistances = [MonType.fighting, MonType.ground, MonType.grass]
            t.weaknesses = [MonType.flying, MonType.rock, MonType.fire]
            t.immunities = []
            
        case MonType.ghost:
            t.resistances = [MonType.poison, MonType.bug]
            t.weaknesses = [MonType.ghost,MonType.dark]
            t.immunities = [MonType.normal, MonType.fighting]
            
        case MonType.steel:
            t.resistances = [MonType.normal, MonType.flying, MonType.rock, MonType.bug, MonType.steel, MonType.grass, MonType.psychic, MonType.ice, MonType.dragon, MonType.fairy]
            t.weaknesses = [MonType.fighting, MonType.ground, MonType.fire]
            t.immunities = [MonType.poison]
            
        case MonType.fire:
            t.resistances = [MonType.bug, MonType.steel, MonType.fire, MonType.grass, MonType.ice, MonType.fairy]
            t.weaknesses = [MonType.ground, MonType.rock, MonType.water]
            t.immunities = []
            
        case MonType.water:
            t.resistances = [MonType.steel, MonType.fire, MonType.water, MonType.ice]
            t.weaknesses = [MonType.grass, MonType.electric]
            t.immunities = []
            
        case MonType.grass:
            t.resistances = [MonType.ground, MonType.water, MonType.grass, MonType.electric]
            t.weaknesses = [MonType.flying, MonType.poison, MonType.bug, MonType.fire, MonType.ice]
            t.immunities = []
            
        case MonType.electric:
            t.resistances = [MonType.flying, MonType.steel, MonType.electric]
            t.weaknesses = [MonType.ground]
            t.immunities = []
            
        case MonType.psychic:
            t.resistances = [MonType.fighting, MonType.psychic]
            t.weaknesses = [MonType.bug, MonType.ghost, MonType.dark]
            t.immunities = []
            
        case MonType.ice:
            t.resistances = [MonType.ice]
            t.weaknesses = [MonType.fighting, MonType.fire, MonType.steel, MonType.rock]
            t.immunities = []
            
        case MonType.dragon:
            t.resistances = [MonType.fire, MonType.water, MonType.grass, MonType.electric]
            t.weaknesses = [MonType.dragon, MonType.ice, MonType.fairy]
            t.immunities = []
            
        case MonType.dark:
            t.resistances = [MonType.ghost, MonType.dark]
            t.weaknesses = [MonType.fighting, MonType.fairy, MonType.bug]
            t.immunities = [MonType.psychic]
            
        case MonType.fairy:
            t.resistances = [MonType.fighting, MonType.bug, MonType.dark]
            t.weaknesses = [MonType.poison, MonType.steel]
            t.immunities = [MonType.dragon]

        }
        
        return t;
    }
}
