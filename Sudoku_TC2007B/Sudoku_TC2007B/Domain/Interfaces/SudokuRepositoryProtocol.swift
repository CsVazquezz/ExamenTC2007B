//
//  SudokuRepositoryProtocol.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation

public protocol SudokuRepositoryProtocol {

    func getPuzzle(difficulty: String) async throws -> SudokuBoard

    func saveGame(id: String, board: SudokuBoard) async throws

    func loadGame(id: String) async throws -> SudokuBoard?
}
