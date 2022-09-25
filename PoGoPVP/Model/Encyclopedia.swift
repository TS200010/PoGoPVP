//
//  KnowledgeItem.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 12/08/2022.
//

//import Foundation
//import SwiftUI

//
// Encyclopedia, KnowledgeItems
// ============================
//
//
// MARK: ENCYCLOPEDIA
//

struct EncyclopediaRepo:  PoGoRepoTraits, CompilerTarget {
    
    func setPlumbing(from compiler: Compiler) {
    }

    func dump() {
    }
    
    var contents: [ Int : any KnowledgeItemTraits ]
    
    mutating func fill()-> Bool {
  
            return true
    }
}

/*
 extension KnowledgeItemTraits {
    init( IDToSet : ID ){
        self.init()
        id = IDToSet
    }
}
*/
//
// MARK: KNOWLEDGE ITEM
//
protocol KnowledgeItemTraits {
    var id: ID { get }
    var kiName : String { get set }
}

struct KnowledgeItemTypeNames : KnowledgeItemTraits {
    var id: ID
    var kiName: String
    var typeNames : Array<String>
}

struct KnowledgeItemTypeColors : KnowledgeItemTraits {
    var id: ID
    var kiName: String
//    var typeColors : Array<Color>
}

//
// MARK: TEST ITEM
//

protocol TestItemTraits{
    var id: ID { get }
    var question: String { get set }
    var questionType: QuestionTypes { get set }
    var answerType: AnswerTypes { get set }
    var correctAnswer: String { get set }
}

extension TestItemTraits {
    func score ( actualAnswer: String ) -> Bool {
            return actualAnswer == correctAnswer
    }
}
    

struct TestItemTypeImage : TestItemTraits{
    var id: ID
    var question: String
    var questionType: QuestionTypes = QuestionTypes.Image
    var answerType: AnswerTypes = AnswerTypes.YesNo
    var correctAnswer: String
}

struct TestItemColor : TestItemTraits{
    var id: ID
    var question: String
    var questionType: QuestionTypes = QuestionTypes.Image
    var answerType: AnswerTypes = AnswerTypes.MultChoiceFixed
    var correctAnswer: String
}

enum QuestionTypes {
    case Text
    case Image
    case Animation
    case Video
}
    
enum AnswerTypes {
    case YesNo
    case MultChoiceFixed
    case MultChoiceRelated
}


