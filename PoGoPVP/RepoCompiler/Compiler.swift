//
//  Compiler.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 29/08/2022.
//

import Foundation

protocol CompilerConstructable{
    var  name: String { get }
    func dump()->Void
}



class Compiler {
    public var  grammerToUse:      Grammer
    public var  parser:            Parser
    public var  lexer:             Lexer
    public var  semAnalyser:       SemAnalyser
    private var stringToParse:     String = ""
    private var semStack:          Stack<Token> = Stack<Token>()

    init( stringToParse: String, tokenListToUse: TokenListTraits, grammerToUse: Grammer, target: Grammer, semAnalyser: SemAnalyser ) {
        self.grammerToUse  = grammerToUse
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
    
    func semPopAsString() -> String{
        var val: String = ""
        switch popSem()! {
        case .terminalSymbol( let t ):
            switch t {
            case .StringLiteral( let s ):
                return s
            case .Identifier( let s ):
                return s
            case .AnyKeyword( let s ):
                return s
            case .ExactKeyword( let s ):
                return s
            case .StringInAngledBrackets( let s ):
                return s
            case .StringInSquareBrackets( let s ):
                return s
            case .StringInCurlyBraces( let s ):
                return s
            case .NumericLiteral( let i ):
                return i.description
            default:
                return ""
            }
        default:
            return ""
        }
    }

    public func peekSem()->Token?{
        return semStack.peek()
    }
    
    public func dumpSemStack()->Void{
        print(semStack)
    }
    
    public func getResult()->CompilerConstructable?{
        return semAnalyser.getTargetAsConstructed()
    }
 
    public func compile( ) -> Bool {
        compilerTrace( s:"COM: \(#function)" )
        if parser.parse() {
            return true
        } else {
            print ("FATAL ERROR: Parser returned false.")
            dumpGrammer()
            return false
        }
    }
}
