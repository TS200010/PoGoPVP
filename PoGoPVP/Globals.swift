//
//  Globals.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 11/06/2022.
//

import Foundation
import SwiftUI

let gLexerTrace = false
let gParserTrace = false
let gSemanticsTrace = false
let gDumpGrammers = false
let gDumpRepos = false
//
// General Purppose Global Declarations
// ====================================
//
protocol AbleToLimitIntValues {
    static var range: Range<Int> { get set }
    var val:  Int { get set }
    func inRange()->Bool
}

extension AbleToLimitIntValues {
    func inRange()-> Bool {
        return Self.range.contains( val )
    }
}

struct HP : AbleToLimitIntValues {
    static var range: Range<Int> = Constants.minHP..<Constants.maxHP+1
    var val: Int = range.lowerBound
}

struct IV : AbleToLimitIntValues {
    static var range: Range<Int> = Constants.minIV..<Constants.maxIV+1
    var val: Int = range.lowerBound
}

//
// Pokemon Related Global Declarations
// ===================================
//
struct Constants {
    static let minHP:  Int = 0     // Probably higher but not an issue
    static let maxHP:  Int = 496   // Blissey
    static let minIV:  Int = 0
    static let maxIV:  Int = 15
    
 }

extension Color {
    static let ui = Color.UI()
    struct UI{
     let Normal = Color("Normal")
     let Fire = Color("Fire")
     let Ghost = Color("Ghost")
    }
    func findColor( in: String ) -> Void{
        
    }
}

struct TypeColours{
    
}

enum eMonTypeNames : Int {
    case normal, fire, water, electric, grass, ice, fighting, poison, ground, flying, psycic, bug, rock, ghost, dragon, dark, steel, fairy
}
  
enum eAttackEffect : Int {
    case NoEffect=0, NotVeryEffective, NormalEffect, SuperEffective
}

//
// Knowledge related GLobal Declarations
// =========
//
enum KnowledgeKind {
    case TypeNameImageColor
    case TypeKanji
    case TypeEffectivenessAttack
    case TypeEffectivenessDefense
    case AnotherKindOfKnowledge
}
