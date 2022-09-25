//
//  ProductionRule.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 03/09/2022.
//

class ProductionRule {
    public var name: String
    public weak var myCompiler: Compiler?
    
    private weak var myGrammer: Grammer?
    private weak var myLexer: Lexer?
    private weak var myParser: Parser?
    private var productions: [ Production ]
    
    init(){
        name = "EmptyPR"
        productions=[]
    }
    
    init(_ name: String ) {
        self.name = name
        self.productions = []
    }
    
    init( _ name: String, elements: Production... ) {
        self.name = name
        self.productions = elements
    }
    
    public func dump()->Void{
        print ( name, " ::= " )
        for p in productions {
            p.dump()
        }
        print("\n")
    }
    
    public func getProductionNamed( name: String )->Production? {
        for p in productions{
            if p.name == name { return p }
        }
        return nil
    }
    
    public func addProduction( production: Production )->Void{
 //       production.myCompiler = myCompiler
        production.name += String( productions.count )
        productions.append( production )
    }
    
    public func setPlumbing( compiler: Compiler ){
        compilerTrace( s:"PRR: \(#function)" )
        myGrammer = compiler.grammerToUse
        myLexer = compiler.lexer
        myParser = compiler.parser
        for p in productions {
            p.setPlumbing( compiler: compiler )
        }
    }
    

    // TODO: Rewrite this comment

    //
    // (1) What happens here is the cycle will repeat one step down. parseElements will find a rule at the start
    // of the PRODUCTION and call parseProductionRule on it. The cycle will repeat until the TOKEN
    // is found. We know it will be because it keeps telling us that it will.
    // We are really parsing now not just checking.


    
    // parseProductionRule
    // ===================
    // Does CURR-TOKEN start any of the productions?
    // YES: call parseElements on the PRODUCTION found
    // NO: does CURR_TOKEN appear deeper?
    //      YES: call parseElements on the PRODUCTION found (1)
    //      NO: syntax error
    public func parseProductionRule( ) -> Bool {
        compilerTrace( s:"PRR: \(#function)" )
    
        // Does the current TOKEN start one of my PRODUCTIONs?
        // ... if so, we can just parse those ELEMENTs
        for p in productions {
            if p.doesCurrentTokenStartMe( ) {
                return p.parseElements( )
            }
        }

        // Not found so we look into each PRODUCTION to see if the current TOKEN is down there somewhere.
        // ... if it is, we parse the the elements of the PRODUCTION (one of my PRODUCTIONS) returned
        // By so doing, we dive a little further down the tree confident we will find the
        //  current TOKEN down there.
        let result = doesCurrentTokenAppearDeeper(  )
        if result.success {
            return getProductionNamed( name: result.nextProductionRef )!.parseElements()
        }

        // If we get here, there is a syntax error
        let t = myLexer!.getCurrentToken()
        print("SYNTAX ERROR 01: Could not find token \(t) in any production of \(name)")
        return false
    }
    
    private func doesCurrentTokenStartOneOfMyProductions(  ) -> ( success:Bool, nextProductionRef:String ) {
        compilerTrace( s:"PRR: \(#function) " )
        for p in productions {
            if p.doesCurrentTokenStartMe( ) {
                return ( true, p.name )
            }
        }
        return ( false, "" )
    }
        
    // doesCurrentTokenAppearDeeper
    // ============================
    // Does CURR-TOKEN start any of the productions?
    // YES: We have navigated to the bottom of the tree. If this is the first call in the recursive loop,
    //      then the production starting with the CURR_TOKEN will be returned.
    // NO:  Cycle through the productions calling ourselves recursively on the first RULE in each
    //      PRODUCTION to look at the next level down.
    // We need to exit passing back the PRODUCTION that contains the RULE within which CURR_TOKEN was found.
    private func doesCurrentTokenAppearDeeper( /*productionToParseNext: inout Production*/ ) -> ( success:Bool, nextProductionRef:String ) {
        compilerTrace( s:"PRR: \(#function)" )
        let result = doesCurrentTokenStartOneOfMyProductions( )
        if result.success {
            return ( true, result.nextProductionRef )
        }
        
        // We need to look into the rules at the first position in each PRODUCTION
        var found = false
        var nextProductionRef = ""
        for p1 in productions {
            let result = p1.doesProductionStartWithARuleReference( )
            if result.success == true {
                let result2 = myGrammer!.getRuleNamed( string: result.nextRuleRef )!.doesCurrentTokenAppearDeeper( )
                if result2.success {
                    found = true
                    nextProductionRef = p1.name
                    break // We found something so jump out - just need to remember top production where
                }
            }
        }
        return (found, nextProductionRef )
    }
}

