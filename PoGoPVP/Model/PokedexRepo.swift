//
//  PokeDexRepo.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 15/08/2022.
//

//
// Pokedex
// =======
//

import Foundation

struct PokeDexEntry /*: Hashable, Decodable*/ {
    var name: String
    var type: PokemonType
    var pokedexNumber: Int
    var possibleFastMoves: Array< any PokemonMoveTraits >
    var possibleChargedMoves: Array< any PokemonMoveTraits >
    static func == (lhs: PokeDexEntry, rhs: PokeDexEntry) -> Bool {
        return lhs.pokedexNumber == rhs.pokedexNumber
    }
}

struct PokedexRepo : PoGoRepoTraits{
    func setPlumbing(from compiler: Compiler) {
    }
    
    func dump() {
        return
    }
    
    static var nextID: ID = 0
    var pokeDex: [PokeDexEntry] = []
    func fill()-> Bool {
       return true
// TODO Fill Pokdex from somewhere
    }
}
