//
//  EnumeratedArray.swift
//  Test2
//
//  Created by Anthony Stanners on 24/06/2022.
//  Copyright © 2022 Anthony Stanners. All rights reserved.
//
// From:
// https://developer.apple.com/forums/thread/7968
//

public struct Fit<T: RawRepresentable>: Comparable where T.RawValue == Int, T: Equatable {
    public static func <(lhs: Fit<T>, rhs: Fit<T>) -> Bool {
        <#code#>
    }
    
    let value: T?
    let count: Int
    init (rawValue: Int?, count: Int) {
        self.count = count
        if let rawValue = rawValue {
            self.value = Fit.resolvedT (rawValue: rawValue, count: count) }
        else {
            self.value = nil
        }
    }
    private static func resolvedT ( rawValue: Int, count: Int) -> T? {
        var rawValue = rawValue
        while rawValue < count {
            if let t = T (rawValue: rawValue) {
                return t
            }
            rawValue++
        }
        return nil
    }
    public func successor () -> Fit {
        if let rawValue = value?.rawValue {
            return Fit (rawValue: rawValue + 1, count: self.count)
        }
        else {
            return Fit (rawValue: nil, count: self.count)
        }
    }
}
public func ==<T> (lhs: Fit<T>, rhs: Fit<T>) -> Bool {
    return lhs.value == rhs.value
}
public struct EnumeratedArray<T: RawRepresentable, U>: SequenceType, CollectionType, DictionaryLiteralConvertible where T.RawValue == Int, T: Equatable {
    
    private var array: [U?] = []
    public subscript (position: Fit<T>) -> U {
        get { return array [position.value!.rawValue]! }
    }
    public subscript (index: T) -> U {
        get { return array [index.rawValue]! }
    }
    public init (dictionaryLiteral elements: (T, U)...) {
        var count = 0
        for (t, _) in elements {
            count = max (count, t.rawValue + 1)
        }
        array = [U?] (count: count, repeatedValue: nil)
        for (t, u) in elements {
            array [t.rawValue] = u
        }
    }
    public var isEmpty: Bool {
        return count == 0
    }
    public var count: Int {
        return array.filter { $0 != nil }.count
    }
    public var startIndex: Fit<T> {
        return Fit<T> (rawValue: 0, count: count)
    }
    public var endIndex: Fit<T> {
        return Fit (rawValue: nil, count: count)
    }
    public func generate () -> EnumeratedArrayGenerator<T, U> {
        return EnumeratedArrayGenerator<T, U> (array: array)
    }
}
