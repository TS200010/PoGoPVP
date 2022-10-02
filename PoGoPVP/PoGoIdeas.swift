//
//  PoGoIdeas.swift
//  Test2
//
//  Created by Anthony Stanners on 23/06/2022.
//  Copyright © 2022 Anthony Stanners. All rights reserved.
//

import Foundation
import SwiftUI


struct KIPokemonType : KnowledgeItemTraits {
    // Required by KnowledgeItemTraits
    var kiName: String = ""
    var kiType: String = ""
    var testType: String = ""
    var testAnswer: String = ""
    
    var pokemon: String = ""
}

struct KIResistances: KnowledgeItemTraits {
    // Required by KnowledgeItemTraits
    var kiName: String = ""
    var kiType: String = ""
    var testType: String = ""
    var testAnswer: String = ""

    var monType: MonType
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

protocol zzzCourse : Collection where Element : Hashable{
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

