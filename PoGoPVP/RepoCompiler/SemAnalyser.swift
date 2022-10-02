//
//  SemAnalyser.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 30/09/2022.
//

import Foundation

protocol SemAnalyser{
    var  myCompiler: Compiler? {get set}
    var  semActions: [String: ( )->Void ] {get set}
    func getTargetAsConstructed()->CompilerConstructable?
    func setCompiler( compiler: Compiler )->Void
    func semDispatch( name: String )->Bool
}

extension SemAnalyser{
    func semDispatch( name: String ) -> Bool {
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        if let semActionToCall = semActions[ name ] {
            semActionToCall( )
        } else {
            print("FATAL ERROR: semAction \(name) not found")
            return false
        }
        return true
    }
}
