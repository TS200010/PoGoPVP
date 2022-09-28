//
//  Lexer.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 19/08/2022.
//

import Foundation

//var expressions = [String: NSRegularExpression]()

public extension String {
    func match(regex: String, start: String.Index, end: String.Index ) -> String? {
        let expression: NSRegularExpression = try! NSRegularExpression(pattern: "^\(regex)", options: [])
        let range = expression.rangeOfFirstMatch(in: self, options: [], range: NSRange(start..<end, in: self) )
        if  ( range.location != NSNotFound ) {
            let retVal = (self as NSString).substring(with: range)
            if gLexerTrace { print("*************FOUND Token: \(retVal)") }
            return (self as NSString).substring(with: range)
        }
        return nil
    }
}

public class Lexer {
    private var stringToParse: String
    private var currIndex: String.Index
    private var currToken: Token
    private var tokenList: any TokenListTraits
    private var eof: Bool = false
    
    init(stringToParse: String, tokenList: any TokenListTraits) {
        self.stringToParse = stringToParse
        self.currIndex = stringToParse.startIndex
        self.tokenList = tokenList
        self.currToken = .noToken
    }
    
    public func isEOF ()->Bool{
        return eof
    }
    
    private func incrementIndex( increment: Int )->Void{
        let i = stringToParse.index(currIndex, offsetBy: increment, limitedBy: stringToParse.endIndex) ?? nil
        if i != nil {
            currIndex = i!
        } else {
            currIndex = stringToParse.endIndex
            print("LEX: End of stringToParse reached.")
            eof = true
        }
    }

    // Used for Error reporting
    // TODO: This does not work at the end of the input stream - it errors out as it passes over the end.
    public func getCurrentPositionAsString() -> String{
        compilerTrace( s:"LEX: \(#function) \(currToken)" )
//        return String(stringToParse.suffix(from: currIndex)).substring(to: stringToParse.index(currIndex, offsetBy: 25, limitedBy: stringToParse.endIndex)!)
   //     return String(stringToParse.suffix(from: currIndex)[...stringToParse.endIndex])

        let endIndex = stringToParse.index(currIndex, offsetBy: 25, limitedBy: stringToParse.endIndex)
        if endIndex == nil {
            return "end of input stream"
        } else {
            return String(stringToParse[currIndex ..< endIndex! ])
        }
    }
    
    public func getCurrentToken()-> Token{
        compilerTrace( s:"LEX: \(#function) \(currToken)" )
        return currToken
    }
    
    private func removeSugarChars( sIn: String )->String{
        var s1 = sIn.replacingOccurrences(of: " ", with: "")
        s1 = s1.replacingOccurrences(of: "\t", with: "")
        s1 = s1.replacingOccurrences(of: "\n", with: "")
        s1 = s1.replacingOccurrences(of: "\r", with: "")
        s1 = s1.replacingOccurrences(of: ":", with: "")
        s1 = s1.replacingOccurrences(of: ",", with: "")
        s1 = s1.replacingOccurrences(of: "<", with: "")
        s1 = s1.replacingOccurrences(of: ">", with: "")
        s1 = s1.replacingOccurrences(of: "[", with: "")
        s1 = s1.replacingOccurrences(of: "]", with: "")
        s1 = s1.replacingOccurrences(of: "{", with: "")
        s1 = s1.replacingOccurrences(of: "}", with: "")
        return s1
    }
    
    @discardableResult public func advanceToNextToken() -> Token {
        compilerTrace( s:"LEX: \(#function) ********************************************* CONSUMED: \(currToken)")
        var found = false
        var token: Token = .noToken
        
        // look for a Token that the Parser would be interested in
        while !found && !eof {
            for (pattern, generator) in tokenList.tokens {
//                print( pattern )
                if let tokenAsString = stringToParse.match(regex: pattern, start:currIndex, end: stringToParse.endIndex) {
                    if let t = generator( tokenAsString ) {
                        token = t
                        incrementIndex( increment: tokenAsString.count )
                        found = true
                        break
                    }
                }
            }
        
            if (!found) {
                // TODO: Fix this reporting - it overflows for errors at end of the input string
//                if gLexerTrace { print ("LEX SKIPPING:  \(stringToParse[currIndex]) ***" /*getCurrentPositionAsString()*/ ) }
                incrementIndex( increment: 1 )
                found = false
            }
            if (token == .terminalSymbol(TerminalSymbol.LineComment)) {
                skipToEndOfLine()
                token = .noToken
                found = false
            }
            if (token == .terminalSymbol(TerminalSymbol.SingleNewLine)) {
                token = .noToken
                found = false
            }
            if (token == .terminalSymbol(TerminalSymbol.Punctuation)) {
                token = .noToken
                found = false
            }
        }
        
        
        // Finally, clean up certain Tokens before passing them on to the Parser
        switch token {
        case .terminalSymbol(.StringLiteral( let s )):
            // Remove quotation marks - normal AND CURLY from WORD
            var s1 = s.replacingOccurrences(of: "\"", with: "")
            s1 = s1.replacingOccurrences(of: "\u{201C}", with: "")
            s1 = s1.replacingOccurrences(of: "\u{201D}", with: "")
            token = Token.terminalSymbol( .StringLiteral( s1 ) )
        case .terminalSymbol(.StringInSquareBrackets( let s )):
            token = Token.terminalSymbol( TerminalSymbol.StringInSquareBrackets( removeSugarChars( sIn: s ) ) )
        case .terminalSymbol(.StringInAngledBrackets( let s )):
            token = Token.terminalSymbol( TerminalSymbol.StringInAngledBrackets( removeSugarChars( sIn: s ) ) )
        case .terminalSymbol(.StringInCurlyBraces( let s )):
            token = Token.terminalSymbol( TerminalSymbol.StringInCurlyBraces( removeSugarChars( sIn: s ) ) )
        case .terminalSymbol(.AnyKeyword( let s )):
            token = Token.terminalSymbol( TerminalSymbol.AnyKeyword( removeSugarChars( sIn: s ) ) )
        case .terminalSymbol(.ExactKeyword( let s )):
            token = Token.terminalSymbol( TerminalSymbol.ExactKeyword( removeSugarChars( sIn: s ) ) )

            
        default:
            break
        }
        
        if gLexerTrace { print ("LEX: ", token) }
        
        currToken = token
        return currToken
    }

    private func skipToEndOfLine()->Void{
        while stringToParse[currIndex] != "\r" && stringToParse[currIndex] != "\n" {
            incrementIndex( increment: 1 )
        }
    }
    
}
        
