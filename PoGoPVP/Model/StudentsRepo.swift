//
//  StudentsRepo.swift
//  Test2
//
//  Created by Anthony Stanners on 26/06/2022.
//  Copyright © 2022 Anthony Stanners. All rights reserved.
//

import Foundation

// Students
// =======
protocol StudentTraits: Hashable {
    var christianName: String { get set }
    var surname: String { get set }
    var nickname: String { get set }
    var score: Int { get set }
//    associatedtype LearnableTraits
    var acquiredKnowledge: [any KnowledgeItemTraits] { get set }    // A collection of HashKeys to the knowledge
//    associatedtype acquiredKnowledge: Collection where acquiredKnowledge.Element: Hashable    // A collection of HashKeys to the knowledge
}

extension StudentTraits {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.nickname      == rhs.nickname
            && lhs.christianName == rhs.christianName
            && lhs.surname       == rhs.surname
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(christianName)
        hasher.combine(surname)
    }
}

struct Student: StudentTraits {
    var christianName:      String = "John"
    var surname:            String = "Smith"
    var nickname:           String = "Jumpy"
    var score:              Int = 0
    var acquiredKnowledge:  [any KnowledgeItemTraits] = []
}

var students: Array< Student > = []


