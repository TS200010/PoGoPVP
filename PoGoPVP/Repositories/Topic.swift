//
//  Topic.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 28/09/2022.
//

import Foundation

struct Topic: CompilerConstructable {
    mutating func fill() -> Bool {
        return true
    }
    
    public var name: String = ""
    public var myCourse: String = ""
    private var kis: [ KnowledgeItemTraits ] = []
    
    mutating func addKI( ki: KnowledgeItemTraits )-> Void {
        kis.append( ki )
    }
    
    func dump() {
        print( "TopicName \(name) from \(myCourse)")
        print( kis )
    }
    
    func setPlumbing(from course: Course) {

    }
    
}
