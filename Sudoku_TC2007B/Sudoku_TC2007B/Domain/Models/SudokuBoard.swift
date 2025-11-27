//
//  APIDTOs.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation

// SudokuBoard.swift
// Domain models for Sudoku

public struct SudokuCell: Codable, Hashable, Identifiable {
    public let id: UUID
    public var row: Int
    public var col: Int
    public var value: Int?
    public var isGiven: Bool
    public var isError: Bool

    public init(id: UUID = UUID(), row: Int, col: Int, value: Int? = nil, isGiven: Bool = false, isError: Bool = false) {
        self.id = id
        self.row = row
        self.col = col
        self.value = value
        self.isGiven = isGiven
        self.isError = isError
    }
}

public struct SudokuBoard: Codable, Hashable {
    public var id: String
    public var size: Int
    public var cells: [SudokuCell]
    public var difficulty: String?

    public init(id: String = UUID().uuidString, size: Int = 9, cells: [SudokuCell] = [], difficulty: String? = nil) {
        self.id = id
        self.size = size
        self.cells = cells
        self.difficulty = difficulty
    }

    public func cellAt(row: Int, col: Int) -> SudokuCell? {
        return cells.first { $0.row == row && $0.col == col }
    }

    public func update(cell: SudokuCell, newValue: Int?) -> SudokuBoard {
        var newCells = cells
        if let idx = newCells.firstIndex(where: { $0.id == cell.id }) {
            var updated = newCells[idx]
            updated.value = newValue
            updated.isError = false
            newCells[idx] = updated
        }
        return SudokuBoard(id: id, size: size, cells: newCells, difficulty: difficulty)
    }
}
