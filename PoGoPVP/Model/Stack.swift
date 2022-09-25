//
//  Stack.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 26/08/2022.
//

import Foundation

struct Stack<T>: CustomStringConvertible{
    var items: [T]=[]
    var description: String{
        return "--- Stack Begin ---\n" +
            items.map({"\($0)"}).joined(separator: "\n") +
            "\n--- Stack End ---\n"
    }
    mutating func push( _ item: T ){
        self.items.insert(item, at: 0)
    }
    
    // TODO: Should this be an Optional return?
    @discardableResult mutating func pop() -> T? {
        if items.isEmpty { return nil }
        return self.items.removeFirst()
    }
    
    // TODO: Should this be an Optional return?
    func peek() -> T? {
        if items.isEmpty { return nil }
        return self.items.first
    }
}
