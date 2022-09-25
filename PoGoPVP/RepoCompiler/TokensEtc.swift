//
//  Tokens.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 19/08/2022.
//

import Foundation

public enum Token : Equatable {
    case terminalSymbol (TerminalSymbol)
    case ruleReference (String)
    case semanticActionReference (String)
    case noToken
    
    public static func == (lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs){
        case (let .terminalSymbol(t1), let .terminalSymbol(t2)):
            // For these Tokens, equality is considered to mean a Token of the same type. The associated
            //    value is not compared.
            if case .StringInSquareBrackets(_) = t1, case .StringInSquareBrackets(_) = t2 {
                return true
            }
            if case .StringInAngledBrackets(_) = t1, case .StringInAngledBrackets(_) = t2 {
                return true
            }
            if case .StringInCurlyBraces(_) = t1, case .StringInCurlyBraces(_) = t2 {
                return true
            }
            if case .AnyKeyword(_) = t1, case .AnyKeyword(_) = t2 {
                return true
            }
            if case .StringLiteral(_) = t1, case .StringLiteral(_) = t2 {
                return true
            }
            if case .Identifier(_) = t1, case .Identifier(_) = t2 {
                return true
            }
            
            // For all other cases, the associated value is compared too.
            return t1==t2
        case (.noToken, .noToken):
            return true

        default:
            return false
        }
    }
}

public enum TerminalSymbol : Equatable {
    case    ProductionEquals
    case    SingleNewLine
    case    LineComment
    case    EndOfGrammer
    case    EndOfProduction
    case    EndOfRule
    case    Punctuation
    case    InjectSymbols
    case    StringLiteral(String)
    case    NumericLiteral(Int32)
    case    Identifier(String)
    case    AnyKeyword(String)
    case    ExactKeyword(String)
    case    EndOfEntries
    case    StringInAngledBrackets(String)
    case    StringInSquareBrackets(String)
    case    StringInCurlyBraces(String)
}

protocol TokenListTraits {
    var tokens: [(String, (String) -> Token? )] { get set }
}

struct MetaParserTokenList : TokenListTraits {
    var tokens: [(String, (String) -> Token? )] = [
        ("#",                         { _          in return .terminalSymbol(.LineComment) }),
        ("::=",                       { _          in return .terminalSymbol(.ProductionEquals) }),
        (":",                         { _          in return .terminalSymbol(.EndOfProduction) }),
        ("<[A-Z][A-Za-z\\-]*>",       { (s:String) in return .terminalSymbol(.StringInAngledBrackets(s)) }),
        ("\\{[A-Z][a-zA-Z\\-]*\\}",   { (s:String) in return .terminalSymbol(.StringInCurlyBraces(s)) }),
        ("\\[[A-Z][a-zA-Z\\-]*\\]",   { (s:String) in return .terminalSymbol(.StringInSquareBrackets(s)) }),
        ("END-OF-GRAMMER",            { _          in return .terminalSymbol(.EndOfGrammer) }),
        ("END-OF-RULE",               { _          in return .terminalSymbol(.EndOfRule) }),
        ("\\*INJECT-SYMBOLS\\*",      { _          in return .terminalSymbol(.InjectSymbols) }),
    ]
}

struct PoGoPVPGrammerTokenList : TokenListTraits {
    var tokens: [(String, (String) -> Token? )] = [
        ("#",                         { _          in return .terminalSymbol(.LineComment) }),
        ("::=",                       { _          in return .terminalSymbol(.ProductionEquals) }),
        (":",                         { _          in return .terminalSymbol(.EndOfProduction) }),
        ("\"([^\"]+)\"",              { (s:String) in return .terminalSymbol(.StringLiteral(s)) } ),
        ("“([^”]+)”",                 { (s:String) in return .terminalSymbol(.StringLiteral(s)) } ),
        ("\\u201C([^\"]+)\\u201D",    { (s:String) in return .terminalSymbol(.StringLiteral(s)) } ),
        ("<[A-Z][A-Za-z\\-]*>",       { (s:String) in return .terminalSymbol(.StringInAngledBrackets(s)) }),
        ("\\{[A-Z][a-zA-Z\\-]*\\}",   { (s:String) in return .terminalSymbol(.StringInCurlyBraces(s)) }),
        ("\\[[A-Z][a-zA-Z\\-]*\\]",   { (s:String) in return .terminalSymbol(.StringInSquareBrackets(s)) }),
        ("END-OF-GRAMMER",            { _          in return .terminalSymbol(.EndOfGrammer) }),
        ("END-OF-RULE",               { _          in return .terminalSymbol(.EndOfRule) }),
        ("END-OF-ENTRIES",            { _          in return .terminalSymbol(.EndOfEntries) }),
        ("\\*INJECT-SYMBOLS*",        { _          in return .terminalSymbol(.InjectSymbols) }),
        ("[A-Z][a-zA-Z\\-\\:]*\\s",   { (s:String) in return .terminalSymbol(.AnyKeyword(s)) }),
        ("[a-z][a-zA-Z0-9]*",         { (s:String) in return .terminalSymbol(.Identifier(s)) }),
        

    ]
}

struct PoGoPVPRepoTokenList : TokenListTraits {
    var tokens: [(String, (String) -> Token? )] = [
        ("#",                         { _          in return .terminalSymbol(.LineComment) }),
        ("::=",                       { _          in return .terminalSymbol(.ProductionEquals) }),
        (":",                         { _          in return .terminalSymbol(.EndOfProduction) }),
        ("END-OF-ENTRIES",            { _          in return .terminalSymbol(.EndOfEntries) }),
        
        ("\"([^\"]+)\"",              { (s:String) in return .terminalSymbol(.StringLiteral(s)) } ),
        ("“([^”]+)”",                 { (s:String) in return .terminalSymbol(.StringLiteral(s)) } ),
        ("\\u201C([^\"]+)\\u201D",    { (s:String) in return .terminalSymbol(.StringLiteral(s)) } ),
        ("[A-Z][a-zA-Z\\-\\:,]*\\s",  { (s:String) in return .terminalSymbol(.ExactKeyword(s)) }),
        ("[0-9]+",                    { (r:String) in return .terminalSymbol(.NumericLiteral((r as NSString).intValue)) }),
        ("[a-z][a-zA-Z0-9:\\-]*",
                             { (s:String) in return .terminalSymbol(TerminalSymbol.Identifier(s)) }),
        

        // TODO: URL does not work
        // Original was https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)
//        ("https?:\\/\\/(www.)?[-a-zA-Z0-9@:%._+~#=]{1,256}.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_+.~#?&//=]*)",
//                            { (s:String) in return .nonTerminalSymbol(NonTerminalSymbol.URL(s)) }),

        //       ("[A-Z]+((\\d)|([A-Z0-9][a-z0-9]+))*([A-Z])?", // camelCase (Google strict definition)

    ]
}




