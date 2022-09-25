//
//  PoGoPVPTests.swift
//  PoGoPVPTests
//
//  Created by Anthony Stanners on 26/08/2022.
//

import XCTest
@testable import PoGoPVP

final class PoGoPVPTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testTokenEqualities()->Void {
        do {
            // First set of tests are True if both are keywords
            var t1:Token = .terminalSymbol(TerminalSymbol.AnyKeyword(""))
            var t2:Token = .terminalSymbol(TerminalSymbol.AnyKeyword(""))
            XCTAssert(t1 == t2)
            
            t1 = .terminalSymbol(TerminalSymbol.AnyKeyword(""))
            t2 = .terminalSymbol(TerminalSymbol.AnyKeyword("ABC"))
            XCTAssert(t1 == t2)
            
            t1 = .terminalSymbol(TerminalSymbol.AnyKeyword("ABC"))
            t2 = .terminalSymbol(TerminalSymbol.AnyKeyword(""))
            XCTAssert(t1 == t2)
            
            t1 = .terminalSymbol(TerminalSymbol.AnyKeyword("ABC"))
            t2 = .terminalSymbol(TerminalSymbol.AnyKeyword("ABC"))
            XCTAssert(t1 == t2)
            
            // Deep compare
            t1 = .terminalSymbol(TerminalSymbol.ExactKeyword(""))
            t2 = .terminalSymbol(TerminalSymbol.ExactKeyword(""))
            XCTAssert(t1 == t2)
            
            t1 = .terminalSymbol(TerminalSymbol.ExactKeyword(""))
            t2 = .terminalSymbol(TerminalSymbol.ExactKeyword("ABC"))
            XCTAssert(t1 != t2)
            
            t1 = .terminalSymbol(TerminalSymbol.ExactKeyword("ABC"))
            t2 = .terminalSymbol(TerminalSymbol.ExactKeyword(""))
            XCTAssert(t1 != t2)
            
            t1 = .terminalSymbol(TerminalSymbol.ExactKeyword("ABC"))
            t2 = .terminalSymbol(TerminalSymbol.ExactKeyword("ABC"))
            XCTAssert(t1 == t2)

            
        }
        
        do {
            // First set of tests are True if both are Numbers
            var t1:Token = .terminalSymbol(TerminalSymbol.NumericLiteral(0))
            var t2:Token = .terminalSymbol(TerminalSymbol.NumericLiteral(0))
            XCTAssert(t1 == t2)
            
            t1 = .terminalSymbol(TerminalSymbol.NumericLiteral(0))
            t2 = .terminalSymbol(TerminalSymbol.NumericLiteral(999))
            XCTAssert(t1 != t2)
            
            t1 = .terminalSymbol(TerminalSymbol.NumericLiteral(999))
            t2 = .terminalSymbol(TerminalSymbol.NumericLiteral(0))
            XCTAssert(t1 != t2)
            
            t1 = .terminalSymbol(TerminalSymbol.NumericLiteral(999))
            t2 = .terminalSymbol(TerminalSymbol.NumericLiteral(999))
            XCTAssert(t1 == t2)
            
        }
    }
    
    func testLexerMetaParserTokenList() {
        let s1 = """
# Comment
::= : <A> {C} [D]
END-OF-GRAMMER
END-OF-RULE
*INJECT-SYMBOLS*

"""
        let tl = MetaParserTokenList()
        let l = Lexer(stringToParse: s1, tokenList: tl )
        var tok1, tok2: Token
        tok1 = .noToken
        tok2 = l.getCurrentToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .ProductionEquals )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .EndOfProduction )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .StringInAngledBrackets("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .StringInCurlyBraces("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .StringInSquareBrackets("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .EndOfGrammer )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .EndOfRule )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )

        tok1 = .terminalSymbol( .InjectSymbols )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
    }
    
    func testLexerPoGoPVPGrammerTokenList()->Void{
        //Note that the CURLY and STRAIGHT quotes are both tested
        let s1 = """
# Comment
::= : "String" “CurlyQUoteString” <A> {B} [C]
END-OF-GRAMMER
END-OF-RULE
END-OF-ENTRIES
*INJECT-SYMBOLS*
ANYCAPSKEY ANYCapLCKey AnyColonKey:
identifier1 idenTIFier2
"""
        let tl = PoGoPVPGrammerTokenList()
        let l = Lexer(stringToParse: s1, tokenList: tl )
        var tok1, tok2: Token
        
        tok1 = .noToken
        tok2 = l.getCurrentToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .ProductionEquals )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .EndOfProduction )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .StringLiteral("") )
        tok2 = l.advanceToNextToken()
        print (tok1, tok2, tok1==tok2 )
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .StringLiteral("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .StringInAngledBrackets("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .StringInCurlyBraces("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .StringInSquareBrackets("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .EndOfGrammer )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .EndOfRule )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .EndOfEntries )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .InjectSymbols )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .AnyKeyword("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .AnyKeyword("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .AnyKeyword("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .Identifier("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
        tok1 = .terminalSymbol( .Identifier("") )
        tok2 = l.advanceToNextToken()
        XCTAssert( tok1 == tok2 )
        
    }
    
    func testParser()->Void{
        //       let resourceToCompile: String = "PoGoPVPGrammer"
        var stringToParse = "*END-OF-GRAMMER"
        var target: Grammer?
        target = Grammer()
        var tokenListToUse = MetaParserTokenList() as TokenListTraits
        var grammerToUse = Grammer.CreateTestGrammer1( tokenList: tokenListToUse )
        let semAnalyserMGS = MetaGrammerSemantics( )
        var compiler     = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS )
//        compiler.setUp()
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        var result: Bool
        result = compiler.compile()
        XCTAssert( result == true )
        XCTAssert( compiler.lexer.isEOF() )
        
        stringToParse = "*END-OF-GRAMMER"
        tokenListToUse = MetaParserTokenList() as TokenListTraits
        grammerToUse = Grammer.CreateTestGrammer2( tokenList: tokenListToUse )
        compiler     = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
//        compiler.setUp();
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        XCTAssert( compiler.compile() == true )
        XCTAssert( compiler.lexer.isEOF() )
        
        stringToParse = """

*END-OF-GRAMMER
"""
        tokenListToUse = MetaParserTokenList() as TokenListTraits
        grammerToUse = Grammer.CreateTestGrammer2( tokenList: tokenListToUse )
        compiler     = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
//       compiler.setUp();
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        var b = compiler.compile()
        XCTAssert( b == true )
        XCTAssert( compiler.lexer.isEOF() )
        
        stringToParse = """
<StringA> *::= <StringB>
*END-OF-GRAMMER
"""
        tokenListToUse = MetaParserTokenList() as TokenListTraits
        grammerToUse = Grammer.CreateTestGrammer3( tokenList: tokenListToUse )
        compiler     = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
//        compiler.setUp();
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        b = compiler.compile()
        XCTAssert( b == true )
        XCTAssert( compiler.lexer.isEOF() )
        
        stringToParse = """
<StringA> *::= <StringB>
*END-OF-GRAMMER
"""
        tokenListToUse = MetaParserTokenList() as TokenListTraits
        grammerToUse = Grammer.CreateTestGrammer4( tokenList: tokenListToUse )
        compiler     = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
//        compiler.setUp();
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        compiler.dumpGrammer()
        b = compiler.compile()
        XCTAssert( b == true )
        XCTAssert( compiler.lexer.isEOF() )
        
        stringToParse = """
<StringA> *::=

*END-OF-GRAMMER
"""
        tokenListToUse = MetaParserTokenList() as TokenListTraits
        grammerToUse = Grammer.CreateTestGrammer5( tokenList: tokenListToUse )
        compiler     = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
//        compiler.setUp();
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        compiler.dumpGrammer()
        b = compiler.compile()
        XCTAssert( b == true )
        XCTAssert( compiler.lexer.isEOF() )
        
        stringToParse = """
<StringA> *::=

<StringB> *::=

<StringC> *::=

*END-OF-GRAMMER
"""
        tokenListToUse = MetaParserTokenList() as TokenListTraits
        grammerToUse = Grammer.CreateTestGrammer5( tokenList: tokenListToUse )
        compiler     = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
//        compiler.setUp();
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        compiler.dumpGrammer()
        b = compiler.compile()
        XCTAssert( b == true )
        XCTAssert( compiler.lexer.isEOF() )
        
        stringToParse = """
<StringA> *::= <StringB>
*END-OF-RULE

<StringC> *::= <StringD> <StringE>
*END-OF-RULE

<StringF> *::= <StringG> <Stringx> <Stringxx> <Stringxxx> <Stringxxxx>
*END-OF-RULE

*END-OF-GRAMMER
"""
        tokenListToUse = MetaParserTokenList() as TokenListTraits
        grammerToUse = Grammer.CreateTestGrammer6( tokenList: tokenListToUse )
        compiler     = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
//        compiler.setUp();
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        compiler.dumpGrammer()
        b = compiler.compile()
        XCTAssert( b == true )
        XCTAssert( compiler.lexer.isEOF() )
        
        stringToParse = """
<StringA> ::= <StringB> [Asd] {Asd}   :
END-OF-RULE

<Asd> ::= [Lll] :
END-OF-RULE

END-OF-GRAMMER
"""
        tokenListToUse =  PoGoPVPGrammerTokenList() as TokenListTraits
        grammerToUse = Grammer.CreateTestGrammer7( tokenList: tokenListToUse )
        compiler     = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
//        compiler.setUp();
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        compiler.dumpGrammer()
        b = compiler.compile()
        XCTAssert( b == true )
        XCTAssert( compiler.lexer.isEOF() )
        
        stringToParse = """
[GrammerName] [RootRule]
<StringA> ::= <StringB> [Asd] {Asd}   :
              <StringC> :
END-OF-RULE

<Asd> ::= [Lll] :
END-OF-RULE

END-OF-GRAMMER
"""
        tokenListToUse =  PoGoPVPGrammerTokenList() as TokenListTraits
        grammerToUse = Grammer.CreateTestGrammer8( tokenList: tokenListToUse )
        compiler     = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
//        compiler.setUp();
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        compiler.dumpGrammer()
        b = compiler.compile()
        XCTAssert( b == true )
        XCTAssert( compiler.lexer.isEOF() )
        
        stringToParse = """
[MetaParserGrammer] [MetaParserRoot]

<MetaParserRoot>              ::= [StringInSquareBrackets] [StringInSquareBrackets]
       {SemGrammerStart} <ProductionRuleListOpt>    :
END-OF-RULE

<ProductionRuleListOpt>          ::= END-OF-GRAMMER {SemGrammerEnd} :
    <ProductionRule> <ProductionRuleListOpt> :
                         
       END-OF-RULE

<ProductionRule>            ::= <DoNotChangeThisStringOrParserWillBreak> {SemRuleStart} ::=
       {SemProductionListStart} <ProductionList> :
       END-OF-RULE

<ProductionList>            ::= <Production> <ProductionListOpt> :
       END-OF-RULE
            
<ProductionListOpt>        ::= END-OF-RULE {SemProductionListEnd} {SemRuleEnd} :
     <Production> <ProductionListOpt> :
       END-OF-RULE
                        
<Production>            ::= {SemProductionStart} <Element> <ElementListOpt> :
       END-OF-RULE


<ElementListOpt>            ::= : {SemProductionEnd} :
                  <Element>  <ElementListOpt> :
       END-OF-RULE
       

<Element>                ::= *INJECT-SYMBOLS* :
       END-OF-RULE
       END-OF-GRAMMER


END-OF-GRAMMER
"""
        tokenListToUse =  PoGoPVPGrammerTokenList() as TokenListTraits
        grammerToUse = Grammer.CreateTestGrammer8( tokenList: tokenListToUse )
        compiler     = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
  //      compiler.setUp();
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        b = compiler.compile()
        compiler.dumpGrammer()
        compiler.dumpSemStack()
        XCTAssert( b == true )
//        XCTAssert( compiler.lexer.isEOF() )
        
        stringToParse = """

  [MetaParserGrammer] [MetaParserRoot]

  <MetaParserRoot>              ::= [StringInSquareBrackets] [StringInSquareBrackets]
         {SemGrammerStart} <ProductionRuleListOpt>    :
  END-OF-RULE

  <ProductionRuleListOpt>          ::= END-OF-GRAMMER {SemGrammerEnd} :
      <ProductionRule> <ProductionRuleListOpt> :
                           
         END-OF-RULE

  <ProductionRule>            ::= <DoNotChangeThisStringOrParserWillBreak> {SemRuleStart} ::=
         {SemProductionListStart} <ProductionList> :
         END-OF-RULE

  <ProductionList>            ::= <Production> <ProductionListOpt> :
         END-OF-RULE
              
  <ProductionListOpt>        ::= END-OF-RULE {SemProductionListEnd} {SemRuleEnd} :
       <Production> <ProductionListOpt> :
         END-OF-RULE
                          
  <Production>            ::= {SemProductionStart} <Element> <ElementListOpt> :
         END-OF-RULE

  <ElementListOpt>            ::= : {SemProductionEnd} :
                    <Element>  <ElementListOpt> :
         END-OF-RULE
         
  <Element>                ::= *INJECT-SYMBOLS* :
         END-OF-RULE
         END-OF-GRAMMER

  END-OF-GRAMMER

"""
        tokenListToUse = MetaParserTokenList() as TokenListTraits
        grammerToUse = Grammer.CreateTestGrammer8( tokenList: tokenListToUse )
        compiler = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        b = compiler.compile()
        compiler.dumpGrammer()
        compiler.dumpSemStack()
        let createdGrammer = compiler.getResult() as CompilerTarget?
        createdGrammer?.dump()
        XCTAssert( b == true )
        XCTAssert( compiler.peekSem() == nil )

        // Use the grammer just created (targetGrammer) to parse itself
        compiler = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: createdGrammer! as! Grammer, target: target!, semAnalyser: semAnalyserMGS  )
        semAnalyserMGS.setCompiler(compiler: compiler)
        createdGrammer!.setPlumbing( from: compiler )
        b = compiler.compile()
        compiler.dumpGrammer()
        compiler.dumpSemStack()
        let targetGrammer2 = compiler.getResult() 
        targetGrammer2?.dump()
        XCTAssert( b == true )
        XCTAssert( compiler.peekSem() == nil )
        
    }
    
    
    func testMetaSem()->Void{
        var stringToParse: String
    
        stringToParse = """
[PoGoPVPGrammer] [PoGoPVPTrainer]
<PoGoPVPTrainer>         ::=     <PoGoPVPTrainerItemListOpt> :

                END-OF-RULE

<PoGoPVPTrainerItemListOpt>    ::=    ENTRY entryId {SemEncEntryStart} <EncyclopediaEntry> END-OF-ENTRY {SemEntryEnd} <PoGoPVPTrainerItemListOpt> :
         COURSE courseId {SemCourseEntryStart} <CourseEntry> END-OF-COURSE {SemCourseEntryEnd} <PoGoPVPTrainerItemListOpt> :
         END-OF-ENTRIES :
                END-OF-RULE
                    
<EncyclopediaEntry>         ::=     FOR-COURSE courseId DATA ( <KnowledgeItem> ) TEST ( <TestItem> ) <HintItem> :
                END-OF-RULE


<KnowledgeItem>            ::=     TypeImageColor ( typeId, Image: “imageFn”, Color: colorId ) {SemTypeImageColor} :
TypeEffectAttack ( Attack: attackId , Defense: defenseId ,
         Effectiveness: effectivenessId) {SemTypeEffectAttack} :
         TypeEffectDefense ( Attack: attackId, Defense: defenseId ,
         Effectiveness: effectivenessId ) {SemTypeEffectDefense} :
                END-OF-RULE
         
<TestItem>            ::=    TextQuestion: “questStr” , AnswerType: <AnswerType> , Answer: “ansStr” {SemTestText} :
         ImageQuestion: “questStr” , Image: “imageFn” , AnswerType: <AnswerType> ,
         Answer: “ansStr” {SemTestImage} :
AnimationQuestion: “questStr” , Support: “supportStr”,
         AnswerType: <AnswerType>,  Answer: “ansStr” {SemTestAnimation} :
         VideoQuestion: “questStr”, Video: “videoFn”, AnswerType: <AnswerType> ,
         Answer: “ansStr” {SemTestVideo} :
         # The Support above is an image, animation, video or URL in XCAssets
                END-OF-RULE
         
<HintItem>            ::=    HINT ( <Hint> ) :
                END-OF-RULE

<Hint>                ::=    Text: “hintStr” {SemHintText} :
                    Image: “hintStr” {SemHintImage} :
                    Animation: “hintStr”, “hintStr” {SemHintAnimation} :
                    Video: “hintStr”  {SemHintVideo} :
                    Web-Address: “URLStr” {SemHintWebAddress} :
                 END-OF-RULE

<AnswerType>            ::=    YESNO {SemAnswerYesNo} :
         MULTICHOICE-FIXED    ( [string] , [string], [string], [string],
         [string], [string] ) {} :
           # Show possible answers randomly out of those suppled here
         MULTICHOICE-RELATED {} :
           # Show four possible answers randomly out of six of the most
           #  recent questions of the same type
                END-OF-RULE
         
<CourseEntry>            ::=     NAME “cseNameStr” {} :
                    DESCRIPTION “cseDescStr” {} :
                    BACKGROUND “bkgdFn” {} :
                    BADGE “badgeFn” {} :
                END-OF-RULE

END-OF-GRAMMER
# The grammer is defined using <>, {}, ::=, :, END-OF-RULE, and END-OF-GRAMMER

# Terminal Symbols:
#   Keywords start with a capital letter
#   Identifiers start with a lower case letter
#   String literals are in “”
#   Numeric literals are numbers

# All puctuation (including round brackets) are considered whitespace

# <NonTerminalSymbols>     are all rules

# “string”            ::=     # any non-quote characters

# [number]            ::=    # any integer (Regex) ???

"""
        let semAnalyserMGS = MetaGrammerSemantics( )
        var target: Grammer?
        target = Grammer()
        var tokenListToUse = MetaParserTokenList() as TokenListTraits
        var grammerToUse = Grammer.CreateTestGrammer8( tokenList: tokenListToUse )
        var compiler = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: target!, semAnalyser: semAnalyserMGS  )
        semAnalyserMGS.setCompiler(compiler: compiler)
        grammerToUse.setPlumbing( from: compiler )
        var b = compiler.compile()
        compiler.dumpGrammer()
        compiler.dumpSemStack()
        let createdGrammer = compiler.getResult() as CompilerTarget?
        createdGrammer?.dump()
        XCTAssert( b == true )
        XCTAssert( compiler.peekSem() == nil )
        
    }
    
    func testRepo()->Void{
        
    }
}

extension Grammer {
    
    // <Root> =  <EndOfGrammer>
    static func CreateTestGrammer1( tokenList: TokenListTraits ) -> Grammer{
        let pRoot_1        = Production    ("Root_1",    elements: .terminalSymbol(.EndOfGrammer))
        var prRoot         = ProductionRule("Root",      elements: pRoot_1)
        let g = Grammer( "TestGrammer1", rootRuleName: "Root" )
        g.addRule( &prRoot )
        return g
    }
    
    // <Root> = <Rule>
    // <Rule> = <EndOfGrammer>
    static func CreateTestGrammer2( tokenList: TokenListTraits ) -> Grammer{
        let pRoot_1        = Production    ("Root_1",    elements: .ruleReference("Rule"))
        var prRoot         = ProductionRule("Root",      elements: pRoot_1)
        let g = Grammer( "TestGrammer2", rootRuleName: "Root" )
        g.addRule( &prRoot )
        
        let pRule_1        = Production    ("Rule_1",    elements: .terminalSymbol(.EndOfGrammer))
        var prRule         = ProductionRule("Rule",      elements: pRule_1)
        g.addRule( &prRule )
        return g
    }
    
    
    // <Root>  ::= <StringInAngledBrackets> = <StringInAngledBrackets> <Rule1>
    // <Rule1> ::= <EndOfGrammer>
    static func CreateTestGrammer3( tokenList: TokenListTraits ) -> Grammer{
        let pRoot          = Production    ("Root",   elements: .terminalSymbol(.StringInAngledBrackets("")),
                                                                .terminalSymbol(.ProductionEquals),
                                                                .terminalSymbol(.StringInAngledBrackets("")),
                                                                .ruleReference("Rule1") )
        var prRoot         = ProductionRule("Root",   elements: pRoot)
        let g = Grammer( "TestGrammer3", rootRuleName: "Root" )
        g.addRule( &prRoot )
        
        let pRule1_1       = Production    ("Rule1-1", elements: .terminalSymbol(.EndOfGrammer) )
        var prRule1        = ProductionRule("Rule1",   elements: pRule1_1 )
        g.addRule( &prRule1 )
        
        return g
    }
    
    // <Root>  ::= <Rule1>
    // <Rule1> ::= <Rule2>
    // <Rule2> ::= <StringInAngledBrackets> = <StringInAngledBrackets> < Rule3>
    // <Rule3> ::= <EndOfGrammer>
    static func CreateTestGrammer4( tokenList: TokenListTraits ) -> Grammer{
        let pRoot          = Production    ("Root",    elements: .ruleReference("Rule1"))
        var prRoot         = ProductionRule("Root",    elements: pRoot)
        let g = Grammer( "TestGrammer4", rootRuleName: "Root" )
        g.addRule( &prRoot )
        
        let pRule1         = Production    ("Rule1_1", elements: .ruleReference("Rule2"))
        var prRule1        = ProductionRule("Rule1",   elements: pRule1)
        g.addRule( &prRule1 )
        
        let pRule2_1       = Production    ("Rule2-1", elements: .terminalSymbol(.StringInAngledBrackets("")),
                                                                 .terminalSymbol(.ProductionEquals),
                                                                 .terminalSymbol(.StringInAngledBrackets("")),
                                                                 .ruleReference("Rule3") )
        let pRule2_2       = Production    ("Rule2-2", elements: .terminalSymbol(.EndOfGrammer) )
        var prRule2        = ProductionRule("Rule2",   elements: pRule2_1, pRule2_2 )
        g.addRule( &prRule2 )

        let pRule3_1       = Production    ("Rule3-1", elements: .terminalSymbol(.EndOfGrammer) )
        var prRule3        = ProductionRule("Rule3",   elements: pRule3_1 )
        g.addRule( &prRule3 )
        return g
    }
    
    // <Root>         ::= <Rule1> <Rule1ListOpt>
    //                    <DoubleNewLine>
    // <Rule1ListOpt> ::= <Rule1> <Rule1ListOpt>
    //                    <EndOfGrammer>
    // <Rule1>        ::= <StringInAngledBrackets> =
    //                    <DoubleNewLine>
    static func CreateTestGrammer5( tokenList: TokenListTraits ) -> Grammer{
        let g = Grammer( "TestGrammer5", rootRuleName: "Root" )
 
        let pRoot1_1         = Production    ("Root1_1",            elements: .ruleReference("Rule1"),
                                                                              .ruleReference("Rule1ListOpt"))
//        let pRoot1_2         = Production    ("Root1_2",            elements: .terminalSymbol(TerminalSymbol.DoubleNewLine ) )
        var prRoot           = ProductionRule("Root",               elements: pRoot1_1/*, pRoot1_2*/ )
        g.addRule( &prRoot )
        
        let pRule1ListOpt1_1 = Production    ("Rule1ListOpt_1",     elements: .ruleReference("Rule1"),
                                                                              .ruleReference("Rule1ListOpt"))
        let pRule1ListOpt1_2 = Production    ("Rule1ListOpt1_2",    elements: .terminalSymbol(.EndOfGrammer ) )
        var prRule1ListOpt   = ProductionRule("Rule1ListOpt", elements: pRule1ListOpt1_1, pRule1ListOpt1_2 )
        g.addRule( &prRule1ListOpt )
        
        let pRule1_1         = Production    ("Rule1-1",            elements: .terminalSymbol(.StringInAngledBrackets("")),
                                                                              .terminalSymbol(.ProductionEquals) )
//        let pRule1_2         = Production    ("Rule1_2",            elements: .terminalSymbol(TerminalSymbol.DoubleNewLine ) )
        var prRule1          = ProductionRule("Rule1",   elements: pRule1_1/*, pRule1_2*/)
        g.addRule( &prRule1 )
        
        return g
    }
    
    // <Root>         ::= <Rule1> <Rule1ListOpt>
    // <Rule1ListOpt> ::= <Rule1> <Rule1ListOpt>
    //                    <EndOfGrammer>
    // <Rule1>        ::= <StringInAngledBrackets> = <ProdList>
    // <ProdList>     ::= <Prod> <ProdListOpt>
    // <ProdListOpt>  ::= <Prod> <ProdListOpt>
    //                    <EndOfRule>
    // <Prod>         ::= <StringInAngledBrackets>
    static func CreateTestGrammer6( tokenList: TokenListTraits ) -> Grammer{
        let g = Grammer( "TestGrammer6", rootRuleName: "Root" )
 
        let pRoot1_1         = Production     ("Root1_1",         elements: .ruleReference("Rule1"),
                                                                              .ruleReference("Rule1ListOpt"))
        var prRoot           = ProductionRule ("Root",            elements: pRoot1_1 )
        g.addRule( &prRoot )
        
        let pRule1ListOpt1_1 = Production     ("Rule1ListOpt_1",  elements: .ruleReference("Rule1"),
                                                                              .ruleReference("Rule1ListOpt"))
        let pRule1ListOpt1_2 = Production     ("Rule1ListOpt1_2", elements: .terminalSymbol(.EndOfGrammer ) )
        var prRule1ListOpt   = ProductionRule ("Rule1ListOpt", elements: pRule1ListOpt1_1, pRule1ListOpt1_2 )
        g.addRule( &prRule1ListOpt )
        
        let pRule1_1         = Production     ("Rule1-1",         elements: .terminalSymbol(.StringInAngledBrackets("")),
                                                                              .terminalSymbol(.ProductionEquals),
                                                                              .ruleReference("ProdList") )
        var prRule1          = ProductionRule ("Rule1",   elements: pRule1_1 )
        g.addRule( &prRule1 )
        
        let pProdList1_1     = Production     ("ProdList1_1",     elements: .ruleReference("Production"),
                                                                              .ruleReference("ProdListOpt"))
        var prProdList       = ProductionRule ("ProdList",        elements: pProdList1_1)
        g.addRule( &prProdList )
        
        let pProdListOpt1_1  = Production     ("ProdListOpt1_1",   elements: .ruleReference("Production"),
                                                                              .ruleReference("ProdListOpt"))
        let pProdListOpt1_2  = Production     ("ProdListOpt1_2",  elements: .terminalSymbol(.EndOfRule))
        var prProdListOpt    = ProductionRule ("ProdListOpt",     elements: pProdListOpt1_1, pProdListOpt1_2)
        g.addRule( &prProdListOpt )
        
        let pProduction1_1   = Production     ("Production",      elements: .terminalSymbol(.StringInAngledBrackets("")) )
        var prProduction     = ProductionRule ("Production",      elements: pProduction1_1)
        g.addRule( &prProduction )
        
        return g
    }
    
    // <Root>         ::= <Rule1> <Rule1ListOpt>
    // <Rule1ListOpt> ::= <Rule1> <Rule1ListOpt>
    //                    <EndOfGrammer>
    // <Rule1>        ::= <StringInAngledBrackets> = <ProdList>
    // <ProdList>     ::= <Prod> <ProdListOpt>
    // <ProdListOpt>  ::= <Prod> <ProdListOpt>
    //                    <EndOfRule>
    // <Prod>         ::= <Element> <ElementListOpt>
    // <ElemListOpt>  ::= <Element> <ElementListOpt>
    //                    <Colon>
    // <Elem>         ::= <StringInAngledBrackets>
    //                    <StringInSquareBrackets>
    //                    <StringInCurlyBraces>
    //                    <EndOfRule>
    static func CreateTestGrammer7( tokenList: TokenListTraits ) -> Grammer{
        let g = Grammer( "TestGrammer7", rootRuleName: "Root" )
 
        let pRoot1_1         = Production    ("Root1_1",            elements: .ruleReference("Rule1"),
                                                                              .ruleReference("Rule1ListOpt"))
        var prRoot           = ProductionRule("Root",               elements: pRoot1_1)
        g.addRule( &prRoot )
        
        let pRule1ListOpt1_1 = Production    ("Rule1ListOpt_1",     elements: .ruleReference("Rule1"),
                                                                              .ruleReference("Rule1ListOpt"))
        let pRule1ListOpt1_2 = Production    ("Rule1ListOpt1_2",    elements: .terminalSymbol(.EndOfGrammer ) )
        var prRule1ListOpt   = ProductionRule("Rule1ListOpt", elements: pRule1ListOpt1_1, pRule1ListOpt1_2 )
        g.addRule( &prRule1ListOpt )
        
        let pRule1_1         = Production    ("Rule1_1",            elements: .terminalSymbol(.StringInAngledBrackets("")),
                                                                              .terminalSymbol(.ProductionEquals),
                                                                              .ruleReference("ProdList") )
        var prRule1          = ProductionRule("Rule1",   elements: pRule1_1)
        g.addRule( &prRule1 )
        
        let pProdList1_1     = Production     ( "ProdList1_1",      elements: .ruleReference("Prod"),
                                                                              .ruleReference("ProdListOpt"))
        var prProdList       = ProductionRule ( "ProdList",         elements: pProdList1_1)
        g.addRule( &prProdList )
        
        let pProdListOpt1_1  = Production     ( "ProdListOpt1_1",   elements: .ruleReference("Prod"),
                                                                              .ruleReference("ProdListOpt"))
        let pProdListOpt1_2  = Production     ( "ProdListOpt1_2",   elements: .terminalSymbol(.EndOfRule))
        var prProdListOpt    = ProductionRule ( "ProdListOpt",      elements: pProdListOpt1_1, pProdListOpt1_2)
        g.addRule( &prProdListOpt )
        
        let pProd1_1         = Production     ("Prod1_1",           elements: .ruleReference("Element"),
                                                                              .ruleReference("ElemListOpt") )
        var prProd           = ProductionRule ("Prod",              elements: pProd1_1)
        g.addRule( &prProd )
        
        let pElemListOpt1_1  = Production     ("ElemListOpt1_1",    elements: .ruleReference("Element"),
                                                                              .ruleReference("ElemListOpt") )
        let pElemListOpt1_2  = Production     ("ElemListOpt1_2",    elements: .terminalSymbol(.EndOfProduction ) )
        var prElemListOpt    = ProductionRule ("ElemListOpt",       elements: pElemListOpt1_1, pElemListOpt1_2 )
        g.addRule( &prElemListOpt )
        
        let pElement1_1     = Production ("Element1_1", elements: .terminalSymbol(.StringInAngledBrackets("")) )
        let pElement2_1     = Production ("Element2_1", elements: .terminalSymbol(.StringInSquareBrackets("")) )
        let pElement3_1     = Production ("Element3_1", elements: .terminalSymbol(.StringInCurlyBraces("")) )
        let pElement5_1     = Production ("Element5_1", elements: .terminalSymbol(.Identifier("")) )
        let pElement6_1     = Production ("Element6_1", elements: .terminalSymbol(.NumericLiteral(0)) )
        let pElement4_1     = Production ("Element4_1", elements: .terminalSymbol(.EndOfRule) )
        let pElement7_1     = Production ("Element7_1", elements: .terminalSymbol(.EndOfGrammer) )
        var prElement       = ProductionRule("Element", elements: pElement1_1, pElement2_1, pElement3_1,
                                             pElement4_1, pElement5_1, pElement6_1, pElement7_1 )
        g.addRule( &prElement )
        
        return g
    }
    
    static func CreateTestGrammer8( tokenList: TokenListTraits ) -> Grammer{
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
 
        var prElement    = ProductionRule("Element",     elements:    pElement1_1, pElement2_1, pElement3_1, pElement4_1,
                                           pElement5_1,  pElement6_1, pElement7_1, pElement8_1 )
                                         
        g.addRule( &prElement )
        
        return g
    }

}
