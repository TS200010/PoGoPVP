//
//  Production.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 03/09/2022.
//

class Production {
    public var name: String
    private weak var myCompiler: Compiler?
    private weak var myGrammer: Grammer?
    private weak var myLexer:   Lexer?
    private weak var myParser:  Parser?
    private weak var mySemanticAnalyser: MetaGrammerSemantics?
    private var elementList: [ Token ]

    init( _ name: String, elements: Token...){
        self.name = "@"+name
        self.elementList = elements
    }
    
    init( _ name: String ){
        self.name = "@"+name
        self.elementList = []
    }
    
    public func dump()->Void{
        print("\t", name)
        for e in elementList {
            print ( "\t\t",e )
        }
    }

    public func insertElementAtStart( item: Token ){
        elementList.insert(item, at: 0 )
    }
    
    public func setPlumbing( compiler: Compiler ){
        compilerTrace( s:"PRO: \(#function)" )
        myCompiler = compiler
        myGrammer  = compiler.grammerToUse
        myLexer    = compiler.lexer
        myParser   = compiler.parser
        mySemanticAnalyser = compiler.semAnalyser as? MetaGrammerSemantics
    }

    // parseElements
    // =============
    // Cycles through all the elements of the PRODUCTION.
    // In the case we are looking at, The PRODUCTION will start with a RULE (skipping any SEM_ACTIONS)
    // but this is not checked its just the way it is as we have examined the syntax tree for that case.
    //
    public func parseElements( ) -> Bool {
        compilerTrace( s:"PRO: \(#function)" )
        var currToken = myLexer?.getCurrentToken()
        for t in elementList {
            currToken = myLexer?.getCurrentToken()
            if gParserTrace { print( "EXPECTING: \(String(describing: t)) EXAMINING: \(String(describing: currToken))", t==currToken) }
            switch t {
            case .terminalSymbol(_):
                if t==currToken {
                    myCompiler?.pushSem(item: currToken! )
                    currToken = myLexer?.advanceToNextToken()
                    continue
                } else {
                    print("SYNTAX ERROR 02: \(String(describing: t)) expected \(String(describing: currToken)) found")
                    return false
                }
                
            case .ruleReference( let s ):
                // TODO: check forced unwrapping OK
                if (myGrammer!.getRuleNamed(string: s))!.parseProductionRule(){
                    continue
                } else {
                    print( "SYNTAX ERROR 04: Production \(s) failed to parse at \(String(describing: currToken))")
                    return false
                }

            case .semanticActionReference( let s ):
                // TODO: check forced unwrapping OK
                mySemanticAnalyser?.semDispatch( name: s )
                continue
                
            case .noToken:
                print("FATAL ERROR: .noToken found unexpectedly")
                return false
            }
        }
        print ("Return TRUE")
        return true
    }
    
    public func doesProductionStartWithARuleReference( ) -> ( success:Bool, nextRuleRef:String ) {
        compilerTrace( s:"PRO: \(#function) \(self)" )
        // TODO: Skip over Semantic Actions more elegantly here - we do not advance LEXER as we will process it later
        var i = 0
        switch elementList[0] {
        case .semanticActionReference(_):
            i = 1
            if elementList.count<=1 {
                return (false, "")
            }
        default:
            break
        }
        
        switch elementList[i] {
        case .ruleReference(let s):
            return (true, s)
        default:
            return (false, "")
        }
    }
    
    public func doesCurrentTokenStartMe( ) -> Bool {
        compilerTrace( s:"PRO: \(#function) \(self)" )
        let t = myLexer!.getCurrentToken()
        var i = 0
        switch elementList[0] {
        case .semanticActionReference(_):
            i = 1
            if elementList.count<=1 {
                return false
            }
        default:
            break
        }
        if gParserTrace { print( "LOOKING FOR: \(t) AT: \( elementList[i])", t==elementList[i]) }
        if elementList[i] == t {
            return true
        }
        return false
    }

}
    


