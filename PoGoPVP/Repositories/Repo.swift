//
//  PoGoRepo.swift
//  Test2
//
//  Created by Anthony Stanners on 26/06/2022.
//  Copyright © 2022 Anthony Stanners. All rights reserved.
//

import Foundation

//typealias ID = UInt64

protocol RepoTarget : CompilerConstructable {
//    mutating func fill()->Bool
    var parent: Repo? { get }

}

class Repo: CustomStringConvertible, CompilerConstructable, RepoTarget {
    // For
    var parent: Repo? = nil
    
    // For CustomStringConvertible
    var description: String = ""
    
    // For CompilerConstructable
    var name: String = ""
    func dump() {
    }
    
    func setPlumbing(from compiler: Compiler) {
        
    }
    
    // For RepoTarget
//    func fill() -> Bool {
//
//    }
    
    
}

