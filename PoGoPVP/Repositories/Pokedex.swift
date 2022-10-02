//
//  Pokedex.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 26/09/2022.
//

import Foundation

struct BaseStats : Codable {
    var atk: Int = 0
    var def: Int = 0
    var hp: Int = 0
}

struct DefaultIVs : Codable {
    var cp500:  [Float] = [0, 0, 0]
    var cp1500: [Float] = [0, 0, 0]
    var cp2500: [Float] = [0, 0, 0 ]
}

struct Family : Codable {
    var id: String = ""
    var evolutions: [String] = [""]
}

struct PvPokePokemon : Codable {
    var dex: Int = 0
    var speciesName: String = ""
    var speciesId: String = ""
//    var baseStats: BaseStats
    var _types: [String] = [""]
//    var fastMoves: [String] = [""]
//    var chargedMoves: [String] = [""]
//    var tags: [String] = [""]
//    var defaultIVs: DefaultIVs
//    var level25CP: Int = 0
//    var buddyDistance: Int = 0
//    var thirdMoveCost: Int = 0
//    var released: Bool = true
//    var family: Family
    var monTypes: [MonType?] = []
    
    enum CodingKeys: String, CodingKey {
        case dex
        case speciesName
        case speciesId
//        case baseStats
        case _types = "types"
//        case fastMoves
//        case chargedMoves
//        case tags
//        case defaultIVs
//        case level25CP
//        case buddyDistance
//        case thirdMoveCost
//        case released
//        case family
        case monTypes
    }
    
    public init( from decoder: Decoder ) throws {
        let container = try decoder.container(keyedBy: PvPokePokemon.CodingKeys.self)
        dex = try container.decode(Int.self, forKey: .dex)
        speciesName = try container.decode(String.self, forKey: .speciesName)
        speciesId = try container.decode(String.self, forKey: .speciesId)
        _types = try container.decode([String].self, forKey: ._types)
        monTypes.append( _types[0].monTypeFromString() )
        monTypes.append( _types[1].monTypeFromString() )



// leave this so we can remember how to do URLs later
//        let sourceURLString = try container.decode(String.self, forKey: .sourceURL)
//        if let url = URL(string: sourceURLString) {
//          sourceURL = url
//        }

    }
}

extension Array {
    public func toDictionary<Key: Hashable>( keySelector: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[keySelector(element)] = element
        }
        return dict
    }
}

struct pokedex {
    var pokemons: [String:PvPokePokemon] = [:]

    mutating func populatePokemons( from data: Data, monList: [Int] )->Bool {
        let decoder = JSONDecoder()
        do {
            let d = try decoder.decode([PvPokePokemon].self, from: data )
            var x = d.filter { x in return monList.contains(x.dex) }
            pokemons = x.toDictionary { $0.speciesId }
        } catch {
            print( "FATAL ERROR: Failed to decode pokemons.json" )
            return false
        }
        return true
    }
    
    func dump()->Void{
        for x in pokemons{ print(x) }
    }
}

