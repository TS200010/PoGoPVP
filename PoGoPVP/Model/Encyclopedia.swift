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

struct EncyclopediaRepo:  RepoTarget, CompilerConstructable {
    var parent: Repo?
    
    var myCompiler: Compiler
    
    var name: String = ""
    
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
//   var id: ID { get }
    var kiName: String { get }
    var kiType: String { get }      // For now
    //  test could be a tuple containing everything ... ?
    var testType: String { get }    // For now
    var testAnswer: String { get }  // For now
}

//struct KIType : KnowledgeItemTraits {
////    var id: ID
//    var kiName: String
//    var kiType: String
//    var typeNames : Array<String>
//}


//
// MARK: TEST ITEM
//

protocol TestItemTraits{
//    var id: ID { get }
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
//    var id: ID
    var question: String
    var questionType: QuestionTypes = QuestionTypes.Image("")
    var answerType: AnswerTypes = AnswerTypes.TrueFalse(true)
    var correctAnswer: String
}

struct TestItemColor : TestItemTraits{
//    var id: ID
    var question: String
    var questionType: QuestionTypes = QuestionTypes.Image("")
    var answerType: AnswerTypes = AnswerTypes.MultChoiceFixed(0)
    var correctAnswer: String
}

enum QuestionTypes {
    case Text (String)
    case Image (String)
    case Animation (String)
    case Video (String)
}
    
enum AnswerTypes {
    case TrueFalse (Bool)
    case MultChoiceFixed (Int)
    case MultChoiceRelated (Int)
}


