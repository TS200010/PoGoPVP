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
    var pokedex = PokedexRepo()
    var stringToParse: String = ""
    
    private mutating func GetStringToParse( resourceToCompile: String ) -> Bool {
        compilerTrace( s:"COM: \(#function) \(resourceToCompile)" )
        if let fileURL = Bundle.main.url(forResource: resourceToCompile, withExtension: "txt"){
            do {
                 try stringToParse = String(contentsOf: fileURL, encoding: .utf8)
            } catch {
                print ("FATAL ERROR: \(resourceToCompile) string contents not obtained")
                return false
//                throw RepoCompilerErrors.CouldNotReadSyntaxFile (resourceToCompile)
            }
        } else {
            print ("FATAL ERROR: \(resourceToCompile) fileURL not obtained")
            return false
//            throw RepoCompilerErrors.DidNotGetURLForSyntax(resourceToCompile)
        }
        return true
    }

    fileprivate mutating func parseGrammer( resourceToCompile: String, tokenListToUse: TokenListTraits, grammerToUse: Grammer, semAnalyserToUse: SemAnalyser )->CompilerTarget? { 
        guard GetStringToParse( resourceToCompile: resourceToCompile) != false else { return nil }
        guard stringToParse != "" else { return nil }
        let targetGrammer = Grammer()
        let compiler = Compiler( stringToParse: stringToParse, tokenListToUse: tokenListToUse, grammerToUse: grammerToUse, target: targetGrammer, semAnalyser: semAnalyserToUse )
        semAnalyserToUse.setCompiler( compiler: compiler )
        grammerToUse.setPlumbing( from: compiler )
        if compiler.compile() {
            return compiler.getResult()
        } else {
            return nil
        }
    }
    
    
    mutating func initialisePoGoModel() -> Bool {
        // Create the META-PARSER-GRAMMER
        // It is CORRECT that we parse the PoGoPVPGrammer ITSELF with the MetaParserTokenList
        // ... think about it!

        // First Compile the MetaGrammer
        let grammerToUse: CompilerTarget = Grammer.CreateMetaParserGrammer( )
        grammerToUse.dump()
        let compiledMPGrammer: CompilerTarget?       = parseGrammer( resourceToCompile: "MetaParserGrammer",
                                                                    tokenListToUse:     MetaParserTokenList( ),
                                                                    grammerToUse:       grammerToUse as! Grammer,
                                                                    semAnalyserToUse:   MetaGrammerSemantics( ) )
        if compiledMPGrammer==nil {
            print ("FATAL ERROR: MetaParserGrammer was not successfully compiled")
            return false }
        if gDumpGrammers { compiledMPGrammer!.dump() }

        // Now we compile the PoGoPVPGrammer
        let compiledPoGoPVPGrammer: CompilerTarget? = parseGrammer( resourceToCompile: "PoGoPVPGrammer",
                                                                    tokenListToUse:    PoGoPVPGrammerTokenList(),
                                                                    grammerToUse:      compiledMPGrammer as! Grammer,
                                                                    semAnalyserToUse:  MetaGrammerSemantics( )  )
     
        if compiledPoGoPVPGrammer == nil {
            print ("FATAL ERROR: PoGoPVPGrammer was not successfully compiled")
            return false }
        if gDumpGrammers { compiledPoGoPVPGrammer!.dump() }

        // Now we start creating the RePo's
        let repositories: CompilerTarget?                    = parseGrammer( resourceToCompile: "PoGoPVPEncyclopedia",
                                                                    tokenListToUse:    PoGoPVPRepoTokenList(),
                                                                    grammerToUse:      compiledPoGoPVPGrammer as! Grammer,
                                                                    semAnalyserToUse:  PoGoRepoSemantics( ) )
        
        let decoder = JSONDecoder()
        let data = Data(stringToDecode.utf8)
        
        var v: [PVPokeMons] = []
    
        do {
            let decoded = try decoder.decode([PVPokeMons].self, from: data )
            v = decoded
            print( decoded )
        } catch {
            print(v)
            print( "Failed to decode" )
        }

        if repositories == nil {
            print ("FATAL ERROR: Repositories were not successfully compiled")
            return false }
        if gDumpRepos { repositories!.dump() }
        
        return true
    }
    
}
