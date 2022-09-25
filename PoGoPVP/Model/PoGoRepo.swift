//
//  PoGoRepo.swift
//  Test2
//
//  Created by Anthony Stanners on 26/06/2022.
//  Copyright © 2022 Anthony Stanners. All rights reserved.
//

import Foundation

typealias ID = UInt64

protocol PoGoRepoTraits : CompilerTarget {
    mutating func fill()->Bool
}

extension PoGoRepoTraits{
    func loadFile( fn: String, ext: String) -> String {
        if let fileURL = Bundle.main.url(forResource: fn, withExtension: ext) {
            if let fileContents = try? String( contentsOf: fileURL ){
                return fileContents
            }
        }
        return ""
    }
}

