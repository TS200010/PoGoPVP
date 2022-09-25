//
//  MonTypes.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 11/06/2022.
//

import Foundation

struct SMonTypes {
private var mt:Matrix<eAttackEffect> = Matrix(rows: 18, columns: 18, defaultValue:.NormalEffect)
    init(){
        mt[.normal, .ghost]   = .NoEffect
        mt[.normal, .rock]    = .NotVeryEffective
        mt[.normal, .steel]   = .NotVeryEffective
        mt[.fire,   .fire ]   = .NotVeryEffective
        mt[.fire,   .water ]  = .NotVeryEffective
        mt[.fire,   .rock ]   = .NotVeryEffective
        mt[.fire,   .dragon ] = .NotVeryEffective
        mt[.fire,   .grass ]  = .SuperEffective
        mt[.fire,   .ice ]    = .SuperEffective
        mt[.fire,   .bug ]    = .SuperEffective
        mt[.fire,   .steel ]  = .SuperEffective
        mt[.water,  .water]   = .NotVeryEffective
        mt[.water,  .grass]   = .NotVeryEffective
        mt[.water,  .dragon]  = .NotVeryEffective
        mt[.water,  .fire ]   = .SuperEffective
    }
}
struct SMonStrings {
private var st:Matrix<String> = Matrix(rows: 18, columns: 18, defaultValue:"No memo")
    init(){
        st[.normal, .ghost]   =  "NORMAL CAN'T SEE GHOSTS: Normal beings have no effect on Ghosts - they can barely even see them"
        st[.normal, .rock]    =  "NORMAL xxx: Normal beings is not very effective on Rocks and Steel - way too hard"
        st[.normal, .steel]   =  "NORMAL xxx: Normal beings is not very effective on Rocks and Steel - way too hard"
        st[.fire,   .fire ]   =  "DON'T FIGHT FIRE WITH FIRE: Fire is not very effective on Fire - its still a fire after they meet"
        st[.fire,   .water ]  =  "WATER SHRUGS OFF FIRE: Fire is not very effective on Water - take a long time to boil away"
        st[.fire,   .rock ]   =  "ROCK DOES NOT BURN: Fire is not very effective on Rock - makes them hot but thats about it"
        st[.fire,   .dragon ] =  "DRAGONS SUCK UP FIRE: Fire is not very effective on Dragons - they can breathe it"
        st[.fire,   .grass ]  =  "FIRE BURNS GRASS: Fire is super effective on Grass - it burns so easily"
        st[.fire,   .ice ]    =  "FIRE MELTS ICE: Fire is super effective on Ice - it melts so easily "
        st[.fire,   .bug ]    =  "FIRE FRYS BUGS: Fire is super effective against bugs - they cant escape it"
        st[.fire,   .steel ]  =  "FIRE MELTS STEEL: Fire is super effective on steel - it ments it"
        
        

        let s0 = "NORMAL and GHOST can touch each other the have no effect"
        let s1 = "GROUND sucks up ELECTRICITY: Ground is super effective attacking ELectric"
        let s2 = "GROUND sucks up ELECTRICITY: Electricity is ineffective attacking Ground"
        let s4 = "Things are built of ROCK and STEEL: this protects normal people : NORMAL has little effect on them"
        let s5 = "FIGHTers will always super damage NORMAL people"
        let s6 = "NORMAL people can't effectively damage anything"
        
        
        
                
    }
}
    
struct STitBit {
    let titBit = "Ghosts and Dragons are botb Super Effective on themselves"
    let titBit2 = "Normal is Super Effective against nothing"
    let titBit3 = "Ghosts and Normal are completely oblivious of each other having No Effect"
    let titBit4 = "Ground cannot touch the Birds - No Effect"
    
}
