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
    
    func getTargetAsConstructed() -> CompilerConstructable? {
        return topicWIP
    }

    var myCompiler: Compiler?
    var myModel: PoGoModel
    var semActions: [String: ( )->Void ] = [:]
    var topicWIP = Topic()
//    var courseWIP = Course()
    var kiPokemonTypeWIP: KIPokemonType?
    var kiResistancesWIP: KIResistances?
    var id: Int=0

    init( model: PoGoModel ){
        self.myModel = model
        self.myCompiler = nil
        semActions["SemStart"]                = { ()->() in self.semStart( ) }
        semActions["SemEnd"]                  = { ()->() in self.semEnd( ) }
        semActions["SemCourseStart"]          = { ()->() in self.semCourseStart( ) }
        semActions["SemCourseEnd"]            = { ()->() in self.semCourseEnd( ) }
        semActions["SemPokemonTypeStart"]     = { ()->() in self.semPokemonTypeStart( ) }
        semActions["SemPokemonTypeEnd"]       = { ()->() in self.semPokemonTypeEnd( ) }
//        semActions["SemPokemonTypeTestStart"] = { ()->() in self.semPokemonTypeTestStart( ) }
        semActions["SemPokemonTypeTestEnd"]   = { ()->() in self.semPokemonTypeTestEnd( ) }
    }
    
    func semStart()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        topicWIP = Topic()
    }
    
    func semEnd()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
    func semCourseStart()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        var courseName: String = ""
        var topicName: String = ""
        if case .terminalSymbol(.Identifier(let s)) = myCompiler!.popSem() {
            topicName = s
        }
        myCompiler!.popSem() // pop TOPIC keyword
        if case .terminalSymbol(.Identifier(let s)) = myCompiler!.popSem() {
            courseName = s
        }
        topicWIP.name = topicName
        topicWIP.myCourse = courseName
        myCompiler!.popSem() // pop COURSE keyword
    }
    
    func semCourseEnd()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
    func semPokemonTypeStart()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        kiPokemonTypeWIP = KIPokemonType()
    }
    
    func semPokemonTypeEnd()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        kiPokemonTypeWIP?.testAnswer = myCompiler!.semPopAsString()
        kiPokemonTypeWIP?.testType = myCompiler!.semPopAsString()
        myCompiler!.popSem() // Discard TEST
        kiPokemonTypeWIP?.pokemon = myCompiler!.semPopAsString()
        kiPokemonTypeWIP?.kiName = topicWIP.name + "-" + id.description + "-" + myCompiler!.semPopAsString()
        id += 1
        topicWIP.addKI( ki: kiPokemonTypeWIP! )
    }
    
    func semPokemonTypeTestEnd()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
}
    
