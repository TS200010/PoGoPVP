//
//  PokemonFromJSON.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 26/09/2022.
//

import Foundation

var stringToDecode =
"""
[{
    "dex": 1,
    "speciesName": "Bulbasaur",
    "speciesId": "bulbasaur",
    "baseStats": {
        "atk": 118,
        "def": 111,
        "hp": 128
    },
    "types": ["grass", "poison"],
    "fastMoves": ["TACKLE", "VINE_WHIP"],
    "chargedMoves": ["POWER_WHIP", "SEED_BOMB", "SLUDGE_BOMB"],
    "tags": ["starter", "shadoweligible"],
    "defaultIVs": {
        "cp500": [18, 2, 14, 7],
        "cp1500": [50, 15, 15, 15],
        "cp2500": [50, 15, 15, 15]
    },
    "level25CP": 627,
    "buddyDistance": 3,
    "thirdMoveCost": 10000,
    "released": true,
    "family": {
        "id": "FAMILY_BULBASAUR",
        "evolutions": ["ivysaur"]
    }
}
]

"""

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

struct PVPokeMons : Codable {
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


