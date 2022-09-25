//
//  Compiler.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 29/08/2022.
//

import Foundation

protocol CompilerTarget{
    func dump()->Void
    func setPlumbing( from compiler: Compiler )->Void
}

protocol SemAnalyser{
    func getTargetAsConstructed()->CompilerTarget?
    func setCompiler( compiler: Compiler )->Void
    func semDispatch( name: String )->Void
}

class Compiler {
    public var  grammerToUse:      Grammer
    public var  parser:            Parser
    public var  lexer:             Lexer
    public var  semAnalyser:       SemAnalyser

    private var stringToParse:     String = ""
    private var semStack:          Stack<Token> = Stack<Token>()
//    private var target:            CompilerTarget?

    init( stringToParse: String, tokenListToUse: TokenListTraits, grammerToUse: Grammer, target: Grammer, semAnalyser: SemAnalyser ) {
        self.grammerToUse  = grammerToUse
//        self.target        = target as any CompilerTarget
        self.stringToParse = stringToParse
        self.lexer         = Lexer  (stringToParse: stringToParse, tokenList: tokenListToUse)
        self.parser        = Parser( grammerToUse: grammerToUse, lexer: lexer)
        self.semAnalyser   = semAnalyser
    }
    
    public func dumpGrammer()-> Void{
        grammerToUse.dump()
    }
 
    public func pushSem( item: Token )->Void{
        semStack.push( item )
    }

    @discardableResult public func popSem(  )->Token?{
        return semStack.pop( )
    }
    
    public func peekSem()->Token?{
        return semStack.peek()
    }
    
    public func dumpSemStack()->Void{
        print(semStack)
    }
    
    public func getResult()->CompilerTarget?{
        return semAnalyser.getTargetAsConstructed()
    }
 
    public func compile( ) -> Bool {
        compilerTrace( s:"COM: \(#function)" )
        if parser.parse() {
//            target = semAnalyser.getTargetAsConstructed()
            return true
        } else {
            return  false }
    }
}
