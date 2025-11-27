//
//  SudokuBoard.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation

public struct SudokuCell: Codable, Hashable {
    public var row: Int
    public var col: Int
    public var value: Int? // nil means empty
    public var isGiven: Bool

    public init(row: Int, col: Int, value: Int? = nil, isGiven: Bool = false) {
        self.row = row
        self.col = col
        self.value = value
        self.isGiven = isGiven
    }
}

public struct SudokuBoard: Codable, Hashable {
    public var id: String
    public var size: Int // typically 9
    public var cells: [SudokuCell]

    public init(id: String = UUID().uuidString, size: Int = 9, cells: [SudokuCell] = []) {
        self.id = id
        self.size = size
        self.cells = cells
    }

    // Convenience accessor
    public func cellAt(row: Int, col: Int) -> SudokuCell? {
        // TODO: return the matching cell
        return nil
    }
}
