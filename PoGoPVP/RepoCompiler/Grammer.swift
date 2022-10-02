//
//  Grammer.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 27/08/2022.
//

//
// GRAMMER is a self-compiling class
// ie the producion rules and their productions actually execute the parse
//

protocol GrammerTarget{
    var myCompiler: Compiler? {get set}
    func setPlumbing( from compiler: Compiler )->Void
}

class Grammer: CustomStringConvertible, CompilerConstructable, GrammerTarget {
    // For CustomStringConvertible
    public var description = ""
    
    // For CompilerConstructable
    public var name: String = ""
    
    public func dump()->Void{
        print(name, "- ", "Root rule: ", rootRuleName, "\n\n\n")
        for (_, val) in rules {
            val.dump()
        }
        print("\n")
    }
    
    public func setPlumbing( from compiler: Compiler ){
        myCompiler = compiler
        for r in rules {
            r.1.setPlumbing( compiler: compiler)
        }
    }
    
    // For GrammerTarget
    public weak var myCompiler: Compiler?
    
    private var rootRuleName: String = ""
    private var defaultRule: ProductionRule?
    private var rules: [ String: ProductionRule ] = [:]
    
    init( _ name: String, rootRuleName: String ) {
        self.description = "Grammer: \(name)"
        self.name = name
        self.rootRuleName = rootRuleName
        // TODO: This default will cause the App to loop if it ever happens
        self.defaultRule = nil
    }
    
    init(){
    }

    
    public func getRuleNamed( string: String ) -> ProductionRule?{
        compilerTrace( s:"GRA: \(#function): \(string)" )
        // TODO: We need to die grracefully here and not just crash
        if rules[string] == nil {
            print( "PARSER ERROR: no rule for \(string) found." )
        }
        return rules[ string ]
    }
    
    public func addRule( _ rule: inout ProductionRule ){
        compilerTrace( s:"GRA: \(#function): RULE \(rule)" )
        rule.myCompiler = myCompiler
        rules[rule.name] = rule
    }
    
    // TODO: Check use of Optionals here
    public func getRoot() -> ProductionRule? {
        compilerTrace( s:"GRA: \(#function): \(rootRuleName)" )
        return rules[ rootRuleName ]
    }
    
    // TODO: Check use of Optionals here
    public func getRule( name: String ) -> ProductionRule? {
        compilerTrace( s:"GRA: \(#function) NAME: \(name)" )
        return rules[ name ]
    }
}
