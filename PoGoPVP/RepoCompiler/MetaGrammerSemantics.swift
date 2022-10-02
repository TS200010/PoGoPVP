//
//  SemGen.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 19/08/2022.
//

import Foundation

// This Semantic Analyser is for doing the semantics for MetaGrammers
class MetaGrammerSemantics : SemAnalyser {
    func setCompiler( compiler: Compiler ) {
        self.myCompiler = compiler
    }
    
    func getTargetAsConstructed() -> CompilerConstructable? {
        return gWIP
    }
    
    var myCompiler: Compiler?
    var semActions: [String: ( )->Void ] = [:]
    var pWIP: Production?
    var rWIP: ProductionRule?
    var gWIP = Grammer()
    
    init( /*compiler: Compiler*/ ){
        self.myCompiler = nil
        semActions["SemGrammerStart"]        = { ()->() in self.semGrammerStart( ) }
        semActions["SemGrammerEnd"]          = { ()->() in self.semGrammerEnd( ) }
        semActions["SemRuleStart"]           = { ()->() in self.semRuleStart( ) }
        semActions["SemRuleEnd"]             = { ()->() in self.semRuleEnd( ) }
        semActions["SemProductionListStart"] = { ()->() in self.semProductionListStart( ) }
        semActions["SemProductionListEnd"]   = { ()->() in self.semProductionListEnd( ) }
        semActions["SemProductionStart"]     = { ()->() in self.semProductionStart( ) }
        semActions["SemProductionEnd"]       = { ()->() in self.semProductionEnd( ) }
    }
    
//    func getXXXAsConstucted()->CompilerConstructable?{
//        return gWIP
//    }

    func semGrammerStart(  )->Void {
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        var root = ""
        if case .terminalSymbol(.StringInSquareBrackets(let s)) = myCompiler!.popSem() {
                root = s
        }
        
        var name = ""
        if case .terminalSymbol(.StringInSquareBrackets(let s)) = myCompiler!.popSem() {
               name = s
        }
        
        gWIP = Grammer(name, rootRuleName: root )
    }
    
    func semGrammerEnd()->Void {
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        // Just pop END-OF-GRAMMER
        myCompiler!.popSem()
    }
    
    func semRuleStart()->Void {
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        var name = ""
        if case .terminalSymbol(.StringInAngledBrackets(let s)) = myCompiler!.popSem() {
               name = s
        }
        rWIP = ProductionRule( name )
    }
    
    func semRuleEnd()->Void {
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        // Pop EndOfRule
        myCompiler!.popSem()
        gWIP.addRule( &rWIP! )
        rWIP = nil
    }
    
    func semProductionListStart()->Void {
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        // There will just be ::= on the stack, all we need to do is pop it
        myCompiler!.popSem()
    }
    
    func semProductionListEnd()->Void {
        compilerTrace( s:"SEM:------------------------ \(#function)" )
    }
    
    func semProductionStart()->Void {
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        pWIP = Production( rWIP!.name )
    }
    
    func semProductionEnd()->Void {
        compilerTrace( s:"SEM:------------------------ \(#function)" )
        // We pop here first to remove the COLON we do not need
        myCompiler!.popSem()
        while myCompiler!.peekSem() != nil {
            let tIn: Token = myCompiler!.popSem()!
            var tOut: Token = tIn
                
            // TODO: The MetaGrammer setup is rather fragile as we are manually plugging the symbols
            // TODO:  needed to parse a MetaGrammer. So which is better... manually coding the
            // TODO:  the MetaGrammer syntax (which takes many attempts to get right) or going through
            // TODO:  these machinations to allow the flexibility of changing the MetaGrammerSyntax...!
            
            // MetaParserGrammer requires special symbols that are hard to create in the input string
            //  .. this will insert them into the output grammer
            // MetaParserGrammer also requires some Token edits...
            switch   tIn {
            case Token.terminalSymbol(TerminalSymbol.InjectSymbols):
//                var t = Token.nonTerminalSymbol(NonTerminalSymbol.SpecialSpecialSpecialStringInAngledBrackets( "SSSSinAB" ))
//                var p = Production( rWIP!.name )
//                p.insertElementAtStart(item: t)
//                rWIP?.addProduction(production: p)
//

                var t = Token.terminalSymbol(.EndOfRule)
                var p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)
                
                t = Token.terminalSymbol(.EndOfProduction)
                p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)

                t = Token.terminalSymbol(.ProductionEquals)
                p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)


                t = Token.terminalSymbol(.StringInAngledBrackets("SinAB"))
                p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)
                
                t = Token.terminalSymbol(.StringInSquareBrackets("SinAB"))
                p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)
                
                t = Token.terminalSymbol(.StringInCurlyBraces("SinCB"))
                p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)
//
//                t = Token.terminalSymbol(.SpecialProductionEquals)
//                p = Production( rWIP!.name )
//                p.insertElementAtStart(item: t)
//                rWIP?.addProduction(production: p)
//
//                t = Token.terminalSymbol(.InjectSymbols)
//                p = Production( rWIP!.name )
//                p.insertElementAtStart(item: t)
//                rWIP?.addProduction(production: p)
//
                t = Token.terminalSymbol(.EndOfGrammer)
                p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)
//
                t = Token.terminalSymbol(.EndOfEntries)
                p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)
//
                t = Token.terminalSymbol(.Identifier(""))
                p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)

                t = Token.terminalSymbol(.AnyKeyword(""))
                p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)

                t = Token.terminalSymbol(.StringLiteral(""))
                p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)
                
                t = Token.terminalSymbol(.NumericLiteral(0))
                p = Production( rWIP!.name )
                p.insertElementAtStart(item: t)
                rWIP?.addProduction(production: p)
//
//                t = Token.terminalSymbol(.SpecialKeyword(""))
//                p = Production( rWIP!.name )
//                p.insertElementAtStart(item: t)
//                rWIP?.addProduction(production: p)
//
//               tOut = Token.nonTerminalSymbol(NonTerminalSymbol.SpecialSpecialSpecialStringInCurlyBraces( "SSSSinCB" ))
                
            case .terminalSymbol(.StringInAngledBrackets(let s)):
                // Convert anything in <> to RULE-REFERENCES
                // TODO: Fix this GLORIOUS HACK!
                // What this does is prevent conversion to a RuleReference the one and only time when "SIAB" needs
                //   to stay as an "SIAB". See also MetaParserGrammer.
                if s != "DoNotChangeThisStringOrParserWillBreak" {
                    tOut = Token.ruleReference( s )
                }
                
            case .terminalSymbol(.StringInCurlyBraces(let s)):
                // Convert anything in {} to SEMANTIC-ACTIONS
                tOut = Token.semanticActionReference( s )
                
            case .terminalSymbol(.AnyKeyword(let s)):
                // We accept AnyKeyword, but the resulting Grammer has to do an exact match
                tOut = Token.terminalSymbol(.ExactKeyword( s ))
                
//            case .nonTerminalSymbol(NonTerminalSymbol.SpecialStringInAngledBrackets(let s)):
//                // Convert SpecialStringInAngledBrackets nonTerminals (Bit like dereferencing in concept)
//                var s1 = s; s1.removeFirst() // Remove the Asterisk
//                tOut = Token.nonTerminalSymbol(NonTerminalSymbol.StringInAngledBrackets( s1 ))
//
//            case .nonTerminalSymbol(NonTerminalSymbol.SpecialSpecialStringInAngledBrackets(let s)):
//                var s1 = s; s1.removeFirst(); s1.removeFirst() // Remove the Asterisks
//                tOut = Token.nonTerminalSymbol(NonTerminalSymbol.SpecialStringInAngledBrackets( s1 ))
//
//            case .nonTerminalSymbol(NonTerminalSymbol.SpecialSpecialSpecialStringInAngledBrackets(let s)):
//                var s1 = s; s1.removeFirst(); s1.removeFirst(); s1.removeFirst() // Remove the Asterisks
//                tOut = Token.nonTerminalSymbol(NonTerminalSymbol.SpecialSpecialStringInAngledBrackets( s1 ))
//
//            case .nonTerminalSymbol(NonTerminalSymbol.SpecialStringInCurlyBraces(let s)):
//                var s1 = s; s1.removeFirst() // Remove the Asterisk
//                tOut = Token.nonTerminalSymbol(NonTerminalSymbol.StringInCurlyBraces( s1 ))
//
//            case .nonTerminalSymbol(NonTerminalSymbol.SpecialSpecialStringInCurlyBraces(let s)):
//                var s1 = s; s1.removeFirst(); s1.removeFirst(); // Remove the Asterisks
//                tOut = Token.nonTerminalSymbol(NonTerminalSymbol.SpecialStringInCurlyBraces( s1 ))
//
//            case .nonTerminalSymbol(NonTerminalSymbol.SpecialSpecialSpecialStringInCurlyBraces(let s)):
//                var s1 = s; s1.removeFirst(); s1.removeFirst(); s1.removeFirst(); // Remove the Asterisks
//                tOut = Token.nonTerminalSymbol(NonTerminalSymbol.SpecialSpecialStringInCurlyBraces( s1 ))
//
//            case .terminalSymbol(.EndOfProduction):
//                // Convert EndOfProduction to SpecialEndOfProduction
//                tOut = .terminalSymbol(.SpecialEndOfProduction)
//                
//            case .terminalSymbol(.EndOfRule):
//                // Convert EndOfRule to SpecialEndOfRule
//                tOut = .terminalSymbol(.SpecialEndOfRule)
//            
//            case .terminalSymbol(.EndOfGrammer):
//                // Convert EndOfGrammer to SpecialEndOfGrammer
//                tOut = .terminalSymbol(.SpecialEndOfGrammer)
//            
//            case .terminalSymbol(.EndOfEntries):
//                // Convert EndOfGrammer to SpecialEndOfGrammer
//                tOut = .terminalSymbol(.SpecialEndOfEntries)
//                
//            case .terminalSymbol(.SpecialKeyword(let s)):
//                var s1 = s; s1.removeFirst() // Remove the asterisk
//                // Convert EndOfGrammer to SpecialEndOfGrammer
//                tOut = .terminalSymbol(.Keyword( s1 ))
                
            default:
                break
            }
            pWIP?.insertElementAtStart(item: tOut)
        }
        
        rWIP?.addProduction(production: pWIP!)
        pWIP = nil
    }
}
