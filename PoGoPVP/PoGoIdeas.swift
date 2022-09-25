//
//  PoGoIdeas.swift
//  Test2
//
//  Created by Anthony Stanners on 23/06/2022.
//  Copyright © 2022 Anthony Stanners. All rights reserved.
//

// HOW TO STOP "THE ERROR"
// https://khawerkhaliq.com/blog/swift-associated-types-self-requirements/


import Foundation
import SwiftUI

typealias Something1 = Int // For now!
typealias Something2 = Int // For now!
typealias Something3 = String // For now!




// First I have a hierachy of protocols to represent my data and managing access to it
protocol A {} // Placeholder for future functionality

protocol AChildP : A {
    var i:   Int { get }
}

typealias BigThings = Int // These will be much bigger than Ints

struct AChild {
    var i:   BigThings
}
// I will add funcs here operating on A to manage the data in AChild

// Next: Some big collection of AChilds - let say an Array for now
let AChilds : Array< AChild > = [ AChild(i:1), AChild(i:2), AChild(i:3) ]
    // This will a huge array so when I head over to accessing it from B I only want to reference it

// Secondly I want a parallel set of protocols to interpret my data. I don't want to copy it
protocol B {
    associatedtype U where U == A // I want the base protocols to be constrained to each other (I think!)
}

protocol BChildP : B {
    var s: String { get }
}

// This is where I get stuck...
// If this were OO then perhaps I would create an Array (or whatever collection type I used with AChilds) of objects
//  that in turn pointed to a corresponding AChild and then referenced the AChilds.
// I could do that here too with a Class I think

// However, I want to stay with Structs - but they are value things. I cant seem to work out how to tie a
//  BChild to its correcponding AChild without a copy being made.



// TypeColours Knowledge
// =====================
protocol TypeColourKnowledgeItemP : KnowledgeItemTraits {
    var typeName: PoGoTypeName { get }
}


// TODO What is this for
// =====================
/*
struct TypeColourKnowledgeItems : TypeColourKnowledgeItemP {
//    var repoItem: Any
    var typeName: TypeName
    var id: ID
    var question: String
    var answer: String
}
*/

// TODO What is this for
// =====================
/*
var Knowledge: [Array<Any>]?

class CKnowledgeItem : KnowledgeItemP {
    var id: ID = 0
    var question: String = ""
    var answer: String = ""
    
}
*/

func AddTypeColourKnowledge()->Void{
    
}

// TypeNames knowledge
// ===================


protocol PokemonTypeEffectivenessAttackKnowledge : KnowledgeItemTraits {
    // The Pokemon
    // Type 1
    // Type 2
}

/*
protocol KnowledgeHash{
//    var hash (kc: KnowledgeClass
    var hash: (kc: KnowledgeClass, number: Something2) { get set }
    
}
*/

// Each Skill is acquired by mastering a BodyOfKnowledge
// A BodyOfKnowledge is a Collection of KnowledgeItems
// The KnowledgeItems are grouped into bitesized chunks
// As the student progresses learning these KnowledgeItems he advances in Level
// When all are learnt Mastery is achieved

protocol BodyOfKnowledgeP : Collection where Element : Hashable {
    // This is a collection of KnowledgeItems
}

protocol AcquiredKnowledgeP : KnowledgeItemTraits {
    // Reference to a KnowledgeItem
}

protocol Course : Collection where Element : Hashable{
    // A Collection of KhowledgeItems
}

protocol Cirriculum : Collection where Element : Hashable{
    // A Collection of Courses
}

// SKILLS
// ======
// A skill is the ability do do something

enum Skill {
    case knowTypeColours
    case knowTypeIcons
    case knowTypeEffectiveness      // 32 levels (8 pairs per levels)
    case knowPKMFastAttacks         // Do this by league
    case knowPKMChargedAttacks
    case knowFastAttackStats
    case knowChargedAttackStats
    case recogniseFastAttackDangers
    case recogniseChargedAttackDangers
    case switchCorrectly
    case knowSomething1
    case knowSomething2
    case countFastAttacks
    case sackSwitch
    case moreskills
}

protocol SkillP {
    var skill: Skill { get }
    var noOfLevels: UInt { get }
}

struct aSkill : SkillP {
    var skill: Skill
    var noOfLevels: UInt
}

let skills : Array< aSkill > = [
    aSkill( skill: Skill.knowTypeEffectiveness, noOfLevels: 32 )
]

// INDIVIDUAL ITEMS TO LEARN
// =========================
//



typealias Score = UInt
typealias Answer = Int      // For now
typealias Question = Int    // For now

protocol QuestionP {
    var questionText: String { get set }
    var questionAanswer: String{ get set }
}

protocol AnswerP {
}

typealias QuestionView = Int // for now

protocol LearnableP {
    var knowledgeItem: KnowledgeItemTraits { get }
    var question: QuestionP { get }
    func makeQuestionView( )->QuestionView
    func getAnswerFromStudent()->Answer    // too simplistic - placeholder for logic/functions
    func scoreAnswer( _ question: Question, _ answer: Answer )->Score
}




protocol SomethingToLearn : LearnableP{
}

