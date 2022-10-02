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
            
        case .noType:
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
            t.weaknesses  = [.fighting]
            t.immunities  = [.ghost]
            
        case .fighting:
            t.resistances = [.rock, .bug, .dark]
            t.weaknesses = [.flying, .psychic, .fairy]
            t.immunities = []
            
        case .flying:
            t.resistances = [.fighting, .bug, .grass]
            t.weaknesses = [.rock, .electric, .ice]
            t.immunities = [.ground]
            
        case .poison:
            t.resistances = [.fighting, .poison, .bug, .fairy,.grass]
            t.weaknesses = [.ground, .psychic]
            t.immunities = []
            
        case .ground:
            t.resistances = [.poison, .rock]
            t.weaknesses = [.water, .grass, .ice]
            t.immunities = [.electric]
            
        case .rock:
            t.resistances = [.normal, .flying, .poison, .fire]
            t.weaknesses = [.fighting, .ground, .steel, .water, .grass]
            t.immunities = []
            
        case .bug:
            t.resistances = [.fighting, .ground, .grass]
            t.weaknesses = [.flying, .rock, .fire]
            t.immunities = []
            
        case .ghost:
            t.resistances = [.poison, .bug]
            t.weaknesses = [.ghost,.dark]
            t.immunities = [.normal, .fighting]
            
        case .steel:
            t.resistances = [.normal, .flying, .rock, .bug, .steel, .grass, .psychic, .ice, .dragon, .fairy]
            t.weaknesses = [.fighting, .ground, .fire]
            t.immunities = [.poison]
            
        case .fire:
            t.resistances = [.bug, .steel, .fire, .grass, .ice, .fairy]
            t.weaknesses = [.ground, .rock, .water]
            t.immunities = []
            
        case .water:
            t.resistances = [.steel, .fire, .water, .ice]
            t.weaknesses = [.grass, .electric]
            t.immunities = []
            
        case .grass:
            t.resistances = [.ground, .water, .grass, .electric]
            t.weaknesses = [.flying, .poison, .bug, .fire, .ice]
            t.immunities = []
            
        case .electric:
            t.resistances = [.flying, .steel, .electric]
            t.weaknesses = [.ground]
            t.immunities = []
            
        case .psychic:
            t.resistances = [.fighting, .psychic]
            t.weaknesses = [.bug, .ghost, .dark]
            t.immunities = []
            
        case .ice:
            t.resistances = [.ice]
            t.weaknesses = [.fighting, .fire, .steel, .rock]
            t.immunities = []
            
        case .dragon:
            t.resistances = [.fire, .water, .grass, .electric]
            t.weaknesses = [.dragon, .ice, .fairy]
            t.immunities = []
            
        case .dark:
            t.resistances = [.ghost, .dark]
            t.weaknesses = [.fighting, .fairy, .bug]
            t.immunities = [.psychic]
            
        case .fairy:
            t.resistances = [.fighting, .bug, .dark]
            t.weaknesses = [.poison, .steel]
            t.immunities = [.dragon]
            
        case .noType:
            t.resistances = []
            t.weaknesses = []
            t.immunities = []

        }
        
        return t;
    }
}
