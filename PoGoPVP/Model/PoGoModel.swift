//
//  CPoGoModel.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 15/08/2022.
//



import Foundation

struct PoGoModel {
    var compiler: Compiler?
    var encyclopedia = EncyclopediaRepo(contents: [:])
    var dex: pokedex?
    var stringToParse: String = ""
    
    private mutating func GetStringToParse( resourceToCompile: String, ext: String ) -> Bool {
        compilerTrace( s:"COM: \(#function) \(resourceToCompile)" )
        if let fileURL = Bundle.main.url(forResource: resourceToCompile, withExtension: ext){
            do {
                 try stringToParse = String(contentsOf: fileURL, encoding: .utf8)
            } catch {
                print ("FATAL ERROR: \(resourceToCompile) string contents not obtained")
                return false
//                throw RepoCompilerErrors.CouldNotReadSyntaxFile( resourceToCompile )
            }
        } else {
            print ("FATAL ERROR: \(resourceToCompile) fileURL not obtained")
            return false
//            throw RepoCompilerErrors.DidNotGetURLForSyntax( resourceToCompile )
        }
        return true
    }

    fileprivate mutating func parseGrammer( resourceToCompile: String, tokenListToUse: TokenListTraits, grammerToUse: Grammer, semAnalyserToUse: SemAnalyser )->CompilerTarget? { 
        guard GetStringToParse( resourceToCompile: resourceToCompile, ext: "txt") != false else { return nil }
        guard stringToParse != "" else { return nil }
        let targetGrammer = Grammer()
        let compiler = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: targetGrammer, semAnalyser: semAnalyserToUse )
        semAnalyserToUse.setCompiler( compiler: compiler )
        grammerToUse.setPlumbing( from: compiler )
        if compiler.compile() != true {
            print("FATAL ERROR: Compiler returned false")
        }
        return compiler.getResult()
    }
    
    
    mutating func initialisePoGoModel() -> Bool {
        // Create the pokedex
        // TODO: Move later so that once we know the pokemon we need we can construct a proper monList
        if GetStringToParse(resourceToCompile: "pokemon", ext: ".json") != true {
            print("FATAL ERROR - Could not find pokedex JSON file")
        }
        let data = Data(stringToParse.utf8)
        let monList = [100, 200, 300]
        dex = pokedex( )
        if dex?.populatePokemons(from: data, monList: monList ) != true {
            print("FATAL ERROR - failed to create pokedex")
        }
        dex!.dump()
        
        // Create the META-PARSER-GRAMMER
        // It is CORRECT that we parse the PoGoPVPGrammer ITSELF with the MetaParserTokenList
        // ... think about it!

        // First Compile the MetaGrammer using hard coded grammer
        let hardCodedGrammer: CompilerTarget = Grammer.CreateMetaParserGrammer( )
        hardCodedGrammer.dump()
        let compiledMPGrammer: CompilerTarget?       = parseGrammer( resourceToCompile: "MetaParserGrammer",
                                                                    tokenListToUse:     MetaParserTokenList(),
                                                                    grammerToUse:       hardCodedGrammer as! Grammer,
                                                                    semAnalyserToUse:   MetaGrammerSemantics() )
        if compiledMPGrammer==nil {
            print ("FATAL ERROR: MetaParserGrammer was not successfully compiled from hard coded grammer")
            return false
        } else {
            if gDumpGrammers { compiledMPGrammer!.dump() }
        }
        
        // Compile the MetaGrammer using the grammer just created (not strictly necessary but a good test)
        let compiledMPGrammer2: CompilerTarget?       = parseGrammer( resourceToCompile: "MetaParserGrammer",
                                                                    tokenListToUse:     MetaParserTokenList(),
                                                                    grammerToUse:       compiledMPGrammer as! Grammer,
                                                                    semAnalyserToUse:   MetaGrammerSemantics() )
        if compiledMPGrammer2==nil {
            print ("FATAL ERROR: MetaParserGrammer was not successfully compiled from recently minted grammer")
            return false
        } else {
            if gDumpGrammers { compiledMPGrammer2!.dump() }
        }
 
        // Compile the Course Grammer - PoGoPVPCourseGrammer
        let PoGoCourseGrammer: CompilerTarget?      = parseGrammer( resourceToCompile: "PoGoPVPCourseGrammer",
                                                                    tokenListToUse:    PoGoPVPGrammerTokenList(),
                                                                    grammerToUse:      compiledMPGrammer2 as! Grammer,
                                                                    semAnalyserToUse:  MetaGrammerSemantics() )
        
        if PoGoCourseGrammer == nil {
            print ("FATAL ERROR: PoGoPVPCourseGrammer was not successfully compiled")
            return false
        } else {
            if gDumpGrammers { PoGoCourseGrammer!.dump() }
        }
        
        // Compile the Couses themselves
        let PoGoCourse_mlsp_s11_01: CompilerTarget? = parseGrammer( resourceToCompile: "PoGoPVP-mlsp-s11-01",
                                                                    tokenListToUse:    PoGoPVPRepoTokenList(),
                                                                    grammerToUse:      PoGoCourseGrammer as! Grammer,
                                                                    semAnalyserToUse:  PoGoRepoSemantics() )
        
        if PoGoCourse_mlsp_s11_01 == nil {
            print ("FATAL ERROR: PoGoCourse_mlsp_s11_01 was not successfully compiled")
            return false
        } else {
            if gDumpGrammers { PoGoCourse_mlsp_s11_01!.dump() }
        }
        
//        // Now we compile the PoGoPVPGrammer - NOT USING ATM
//        let compiledPoGoPVPGrammer: CompilerTarget? = parseGrammer( resourceToCompile: "PoGoPVPGrammer",
//                                                                    tokenListToUse:    PoGoPVPGrammerTokenList(),
//                                                                    grammerToUse:      compiledMPGrammer as! Grammer,
//                                                                    semAnalyserToUse:  MetaGrammerSemantics() )
//
//        if compiledPoGoPVPGrammer == nil {
//            print ("FATAL ERROR: PoGoPVPGrammer was not successfully compiled")
//            return false }
//        if gDumpGrammers { compiledPoGoPVPGrammer!.dump() }
        
//
//        // Now we start creating the RePo's
//        let repositories: CompilerTarget?                    = parseGrammer( resourceToCompile: "PoGoPVPEncyclopedia",
//                                                                    tokenListToUse:    PoGoPVPRepoTokenList(),
//                                                                    grammerToUse:      compiledPoGoPVPGrammer as! Grammer,
//                                                                    semAnalyserToUse:  PoGoRepoSemantics( ) )
//
//        if repositories == nil {
//            print ("FATAL ERROR: Repositories were not successfully compiled")
//            return false }
//        if gDumpRepos { repositories!.dump() }
        
        return true
    }
    
}
