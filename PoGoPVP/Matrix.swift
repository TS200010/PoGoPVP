//
//  Matrix.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 11/06/2022.
//

import Foundation

struct Matrix<T> {
    let rows: Int, columns: Int
    var grid: [T]
    init( rows: Int, columns: Int, defaultValue: T) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: defaultValue, count: rows * columns) //as! [T]
    }
    func indexIsValid( row: Int, column: Int ) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(_ row: Int, _ column: Int) -> T {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set ( newValue ){
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
    subscript(_ row: eMonTypeNames, _ column: eMonTypeNames ) -> T {
        get {
            assert(indexIsValid(row: row.rawValue, column: column.rawValue), "Index out of range")
            return grid[(row.rawValue * columns) + column.rawValue]
        }
        set ( newValue ){
            assert(indexIsValid(row: row.rawValue, column: column.rawValue), "Index out of range")
            grid[(row.rawValue * columns) + column.rawValue] = newValue
        }
    }
}
