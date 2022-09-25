//
//  PokemonRepo.swift
//  Test2
//
//  Created by Anthony Stanners on 26/06/2022.
//  Copyright © 2022 Anthony Stanners. All rights reserved.
//

import Foundation


/*
protocol Pokemon : Hashable {
    var name: String { get }
    var type: PokemonType { get }
    var pokedex: Int { get }
    // Moves folows
    associatedtype C: Collection where C.Element: Hashable  // This one
    var possibleFastMoves1: C { get set }
    var possibleFastMoves2: Array<PokemonMove>   { get set }           // ... or this one?
    var possibleChargedMoves: Array<Move> { get set }
    var fastMove: Move { get }
    var chargedMove1: Move { get }
    var chargedMove2: Move { get }
}
*/




struct Pokemon /*: Hashable, Decodable*/ {
    static var nextLearnableID: ID = 0
    var pokedexNumber: Int
    var fastMove: PokemonMove
    var chargedMove1: PokemonMove
    var chargedMove2: PokemonMove
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.pokedexNumber == rhs.pokedexNumber
    }
    
}

class PokemonRepo : PoGoRepoTraits{
    func setPlumbing(from compiler: Compiler) {
        return
    }
    
    func dump() {
        return
    }
    
    static var nextID: ID = 0
    var pokemons: [Pokemon] = []
    func fill()-> Bool {
       return true
// TODO Fill Pokdex from somewhere
    }
}

