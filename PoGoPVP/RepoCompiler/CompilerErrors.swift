//
//  CompilerErrors.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 03/09/2022.
//

import Foundation

enum RepoCompilerErrors : Error {
    case CouldNotReadSyntaxFile (String)
    case DidNotGetURLForSyntax(String)
}
