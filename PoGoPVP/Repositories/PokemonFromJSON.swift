//
//  PokemonFromJSON.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 26/09/2022.
//

import Foundation

struct BaseStats : Codable {
    var atk: Int
    var def: Int
    var hp: Int
}

struct DefaultIVs : Codable {
    var cp500:  [Float]
    var cp1500: [Float]
    var cp2500: [Float]
}

struct Family : Codable {
    var id: String
    var evolutions: [String]
}

struct PvPokePokemon : Codable {
    var dex: Int
    var speciesName: String
    var speciesId: String
    var baseStats: BaseStats
    var types: [ String ]
    var fastMoves: [String]
    var chargedMoves: [String]
    var tags: [String]
    var defaultIVs: DefaultIVs
    var level25CP: Int
    var buddyDistance: Int
    var thirdMoveCost: Int
    var released: Bool
    var family: Family
}

struct pokedex {
    var pokemons: [PvPokePokemon] = []

    mutating func populatePokemons( from data: Data )->Bool {
        let decoder = JSONDecoder()
        do {
            let d = try decoder.decode([PvPokePokemon].self, from: data )
            pokemons = d
            print( pokemons )
        } catch {
            print( "Failed to decode" )
            return false
        }
        return true
    }
}

