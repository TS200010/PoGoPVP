//
//  Parser.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 26/08/2022.
//

enum parserError : Error {
    case parserErrorCouldNotFindProduction
    case productionElementListEmpty
}

func compilerTrace( s: String ){
    if gParserTrace {
        print( s )
    }
}

class Parser{
    public let grammerInUse: Grammer
    
    private var myLexer: Lexer
    
    init(  grammerToUse: Grammer, lexer: Lexer ){
        self.grammerInUse = grammerToUse
        self.myLexer = lexer
    }
    
    public func parse( ) -> Bool{
        compilerTrace( s:"PAR: \(#function)" )
        myLexer.advanceToNextToken()
        if let root = grammerInUse.getRoot() {
            return root.parseProductionRule( )
        } else {
            // TODO: Error Processing
            print("FATAL ERROR - Root Rule has no productions")
            return false
        }
    }
}


