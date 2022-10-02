//
//  Course.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 27/09/2022.
//

import Foundation

struct Course {
    public var name: String 
    public var topics: [String: Topic] = [:]
//    public var myCourseRepo: String
    var badge: String = ""
    
    func dump() {
        print( "Course: \(name)")
        for t in topics { t.value.dump() }
    }
    
    mutating func addTopic( name: String, topic: Topic ){
        topics[name] = topic
    }
    
    func getTopicNamed( name: String ) -> Topic? {
        return topics[ name ]
    }
}




