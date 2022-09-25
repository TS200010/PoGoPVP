//
//  PoGoRepoSemAnalysis.swift
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
    var encWIP: PoGoRepoTraits?

    init( ){
        self.myCompiler = nil
        semActions["SemEncEntryStart"]        = { ()->() in self.semEncEntryStart( ) }
        semActions["SemEncEntryEnd"]          = { ()->() in self.semEncEntryEnd( ) }
        semActions["SemTypeImageColor"]       = { ()->() in self.semTypeImageColor( ) }
        semActions["SemTypeEffectAttack"]     = { ()->() in self.semTypeEffectAttack( ) }
        semActions["SemTypeEffectDefense"]    = { ()->() in self.semTypeEffectDefense( ) }
    }
    
    func semDispatch( name: String ) -> Void {
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        if let semActionToCall = semActions[ name ] {
            semActionToCall( )
        }
    }
    
    func semEncEntryStart()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        let e = myCompiler?.popSem()
    }
    
    func semEncEntryEnd()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
    func semTypeImageColor()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        // We have colorID, "imageFn" and typeID on the stack in that order
        let e = myCompiler?.popSem()
    }
    
    func semTypeEffectAttack()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
    func semTypeEffectDefense()->Void{
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
}
    
