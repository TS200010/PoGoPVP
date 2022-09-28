//
//  PoGoPVPCourseSemAnalyser.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 16/09/2022.
//

import Foundation

// This Semantic Analyser is for doing the semantics for PoGoRepo's
class PoGoRepoSemantics : SemAnalyser {
    func setCompiler( compiler: Compiler ) {
        self.myCompiler = compiler
    }
    
    func getTargetAsConstructed() -> CompilerTarget? {
        return encWIP
    }

    var myCompiler: Compiler?
    var semActions: [String: ( )->Void ] = [:]
    var encWIP: Course?

    init( ){
        self.myCompiler = nil
        semActions["SemGrammerStart"]         = { ()->() in self.semGrammerStart( ) }
        semActions["SemGrammerEnd"]           = { ()->() in self.semGrammerEnd( ) }
        semActions["SemCourseStart"]          = { ()->() in self.semCourseStart( ) }
        semActions["SemCourseEnd"]            = { ()->() in self.semCourseEnd( ) }
        semActions["SemPokemonTypeStart"]     = { ()->() in self.semPokemonTypeStart( ) }
        semActions["SemPokemonTypeEnd"]       = { ()->() in self.semPokemonTypeEnd( ) }
        semActions["SemPokemonTypeTestStart"] = { ()->() in self.semPokemonTypeTestStart( ) }
        semActions["SemPokemonTypeTestEnd"]   = { ()->() in self.semPokemonTypeTestEnd( ) }
    }
    
    func semDispatch( name: String ) -> Void {
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        if let semActionToCall = semActions[ name ] {
            semActionToCall( )
        }
    }
    
    func semGrammerStart()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        encWIP = Course()
    }
    
    func semGrammerEnd()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
    func semCourseStart()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
    func semCourseEnd()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
    func semPokemonTypeStart()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
    func semPokemonTypeEnd()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
    func semPokemonTypeTestStart()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
    func semPokemonTypeTestEnd()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
}
    
