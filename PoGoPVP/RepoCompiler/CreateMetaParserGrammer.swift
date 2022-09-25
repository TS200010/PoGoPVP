//
//  CreateMetaParserGrammer.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 27/08/2022.
//

import Foundation

extension Grammer {
    
    static func CreateMetaParserGrammer( /*tokenList: TokenListTraits*/ ) -> Grammer {
        let g = Grammer( "MetaParserGrammer", rootRuleName: "MetaParserRoot"/*, tokenList: tokenList*/ )
        
        let pMetaParserRoot_1        = Production     ("MetaParserRoot_1",        elements:
                                                       .terminalSymbol(.StringInSquareBrackets("")),
                                                       .terminalSymbol(.StringInSquareBrackets("")),
                                                       .semanticActionReference("SemGrammerStart"),
//                                                       .ruleReference("ProductionRule"),
                                                       .ruleReference("ProductionRuleListOpt"))
        var prMetaParserRoot         = ProductionRule ("MetaParserRoot",          elements:  pMetaParserRoot_1 )
        g.addRule( &prMetaParserRoot )
        
        let pProductionRuleListOpt_1 = Production     ("ProductionRuleListOpt_1", elements:
                                                       .terminalSymbol(.EndOfGrammer ),
                                                       .semanticActionReference("SemGrammerEnd") )
        let pProductionRuleListOpt_2 = Production     ("ProductionRuleListOpt_2", elements: .ruleReference("ProductionRule"),
                                                       .ruleReference("ProductionRuleListOpt"))
        var prProductionRuleListOpt  = ProductionRule ("ProductionRuleListOpt",   elements:  pProductionRuleListOpt_1,
                                                                                             pProductionRuleListOpt_2 )
        g.addRule( &prProductionRuleListOpt )
        
        let pProductionRule_1         = Production    ("ProductionRule_1",        elements:
                                                       .terminalSymbol(.StringInAngledBrackets("")),
                                                       .semanticActionReference("SemRuleStart"),
                                                       .terminalSymbol(.ProductionEquals),
                                                       .semanticActionReference("SemProductionListStart"),
                                                       .ruleReference("ProductionList") )
        var prProductionRule          = ProductionRule("ProductionRule",          elements:  pProductionRule_1 )
        g.addRule( &prProductionRule )
        
        let pProductionList_1         = Production    ("ProductionList_1",        elements:
                                                       .ruleReference("Production"),
                                                       .ruleReference("ProductionListOpt"))
        var prProductionList          = ProductionRule("ProductionList",          elements:  pProductionList_1)
        g.addRule( &prProductionList )
        
        let pProductionListOpt_1     = Production     ("ProductionListOpt_1",     elements:
                                                       .terminalSymbol(.EndOfRule),
                                                       .semanticActionReference("SemProductionListEnd"),
                                                       .semanticActionReference("SemRuleEnd"))
        let pProductionListOpt_2     = Production     ("ProductionListOpt_2",     elements:
                                                       .ruleReference("Production"),
                                                       .ruleReference("ProductionListOpt"))

        var prProductionListOpt      = ProductionRule ("ProductionListOpt",       elements:  pProductionListOpt_1,
                                                                                             pProductionListOpt_2)
        g.addRule( &prProductionListOpt )
        
        let pProduction_1            = Production     ("Production_1",            elements:
                                                       .semanticActionReference("SemProductionStart"),
                                                       .ruleReference("Element"),
                                                       .ruleReference("ElementListOpt") )
        var prProduction             = ProductionRule ("Production",              elements:  pProduction_1)
        g.addRule( &prProduction )
        
        let pElementListOpt_1        = Production     ("ElementListOpt1_1",       elements:
                                                       .terminalSymbol(.EndOfProduction ),
                                                       .semanticActionReference("SemProductionEnd"))
        let pElementListOpt_2        = Production     ("ElementListOpt1_2",       elements:
                                                       .ruleReference("Element"),
                                                       .ruleReference("ElementListOpt") )

        var prElementListOpt   = ProductionRule       ("ElementListOpt",          elements:  pElementListOpt_1,
                                                                                             pElementListOpt_2 )
        g.addRule( &prElementListOpt )
        let pElement1_1 = Production     ("Element1_1", elements: .terminalSymbol   ( .InjectSymbols) )
        let pElement2_1 = Production     ("Element2_1", elements: .terminalSymbol   ( .EndOfGrammer) )
        let pElement3_1 = Production     ("Element3_1", elements: .terminalSymbol   ( .ProductionEquals) )
        let pElement4_1 = Production     ("Element4_1", elements: .terminalSymbol   ( .EndOfProduction) )
        let pElement5_1 = Production     ("Element5_1", elements: .terminalSymbol   ( .EndOfRule) )
        let pElement6_1 = Production     ("Element6_1", elements: .terminalSymbol   ( .StringInAngledBrackets("SIAB")) )
        let pElement7_1 = Production     ("Element7_1", elements: .terminalSymbol   ( .StringInCurlyBraces("SICB")) )
        let pElement8_1 = Production     ("Element8_1", elements: .terminalSymbol   ( .StringInSquareBrackets("SISB")) )

 
        var prElement    = ProductionRule("Element",     elements:    pElement1_1, pElement2_1, pElement3_1,
                                          pElement4_1,  pElement5_1,  pElement6_1, pElement7_1, pElement8_1 )
        g.addRule( &prElement )
        
        return g
    }
}
