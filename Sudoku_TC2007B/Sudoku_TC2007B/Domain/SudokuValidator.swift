//
//  SudokuValidator.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation

// Domain-level validator for Sudoku rules

public protocol SudokuValidatorProtocol {
    func validate(board: SudokuBoard) async throws -> Bool
}

public struct SudokuValidator: SudokuValidatorProtocol {
    public init() {}

    public func validate(board: SudokuBoard) async throws -> Bool {
        // TODO: Implement full Sudoku validation (rows, columns, subgrids)
        throw NSError(domain: "SudokuValidator", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not implemented"])
    }
}
