//
//  PokemonMovesRepo.swift
//  Test2
//
//  Created by Anthony Stanners on 26/06/2022.
//  Copyright © 2022 Anthony Stanners. All rights reserved.
//

import Foundation

// Pokemon Moves Repository
// =======================
//
// This repository contains the truth about Pokemon Moves

enum MoveName: Int {
    case ShadowBall = 0
    case FirePunch  = 1
    case Yawn       = 2
}

protocol PokemonMoveTraits : RepoTarget, Hashable {
    var name: String { get }
    var typeName: MonType { get }
    // Other traits of PoGo Moves
}

extension PokemonMoveTraits {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name  == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine( name )
    }
}
 
struct PokemonMove : PokemonMoveTraits/*, Decodable*/ {
    var parent: Repo?
    
    func setPlumbing(from compiler: Compiler) {
    }
    
    func dump() {
        return
    }
    
//    static var nextID: ID = 0

    var name: String
    var typeName: MonType
    func fill()->Bool { return true }
}


// Nah... this is not the way to do it, we need to read from a file (JSON ?)
// .. or perhaps get from ...? GIT: https://github.com/kinkofer/PokemonAPI

let pokemonMoves: Array< any PokemonMoveTraits > = [
    PokemonMove( name: "Shadow Ball", typeName: .ghost  ),
    PokemonMove( name: "Fire Punch",  typeName: .fire   ),
    PokemonMove( name: "Yawn",        typeName: .normal )
]

func TestPokemonMove()->Void {
    let a = pokemonMoves[ MoveName.ShadowBall.rawValue ]
    let b = pokemonMoves[ 1 ]
}

