//
//  PokemonTypesRepo.swift
//  Test2
//
//  Created by Anthony Stanners on 26/06/2022.
//  Copyright © 2022 Anthony Stanners. All rights reserved.
//

import Foundation
import SwiftUI

// Pokemon Types Repository
// =======================
//
// This repository contains the truth about Pokemon Types
//

protocol PokemonTypeTraits /*: Decodable*/ {
    var type:   MonType { get }
    var color:  Color { get }
    var image:  String { get }
}

struct PokemonType : PokemonTypeTraits {
    var type:   MonType
    var color:  Color
    var image:  String
}

let pokemonTypesRepo : Array< PokemonType > = [
    PokemonType( type:MonType.normal, color: Color.ui.normal, image: "Image Name Normal"),
    PokemonType( type:MonType.fire,   color: Color.ui.fire,   image: "Image Name Fire"),
    PokemonType( type:MonType.ghost,  color: Color.ui.ghost,  image: "Image Name Ghost")
]
 

// ------------------------------Test Code------------------------------
/*
 The code here was to test different iplementations of the repo to see which is most convenient to use
 I settled on Array as access did not return an optional even though indexing is more verbose
 
// Try implementation as an Array<>
let typesArray : Array< PokemonType > = [
    PokemonType( type:PoGoTypeName.Normal, color: Color.ui.Normal, image: "Image Name Normal"),
    PokemonType( type:PokemonTypeName.Fire,   color: Color.ui.Fire,   image: "Image Name Fire"),
    PokemonType( type:PokemonTypeName.Ghost,  color: Color.ui.Ghost,  image: "Image Name Ghost")
]
 
 func TestTypesArray()->Void {
     let a: PokemonType = typesArray[ 1 ]
     let e: PokemonType = typesArray[ PokemonTypeName.Normal.rawValue ]
     let b: PokemonType = typesArray[ a.type.rawValue ]
 let t = PokemonTypeName.Normal
 let c = typesArray[ t.rawValue ]
 let d = typesArray[ PokemonTypeName.Normal.rawValue ]
 let s = String(describing: a)
 }
 
// Try implementation as a Dictionary<> that looks up the entry based on the enum

let typesDictionery: Dictionary< PokemonTypeName, PokemonType > = [
    .Normal:    PokemonType( type:.Normal,  color: Color.ui.Normal, image: "Image Name Normal"),
    .Fire:      PokemonType( type:.Fire,    color: Color.ui.Fire,   image: "Image Name Fire"),
    .Ghost:     PokemonType( type:.Ghost,   color: Color.ui.Ghost,  image: "Image Name Ghost")
    ]

func TestTypesDictionery()->Void {
    let a: PokemonType? = typesDictionery[ .Normal ];                   print( a as Any )
    let b: PokemonType? = typesDictionery[ PokemonTypeName.Normal ];    print( b! )
}
*/


