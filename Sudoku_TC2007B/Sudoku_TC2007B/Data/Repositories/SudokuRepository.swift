//
//  SudokuRepository.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation

// Data layer - Repositories


public final class SudokuRepository: SudokuRepositoryProtocol {
    private let apiService: SudokuAPIServiceProtocol
    private let storageService: GameStorageServiceProtocol

    public init(apiService: SudokuAPIServiceProtocol, storageService: GameStorageServiceProtocol) {
        self.apiService = apiService
        self.storageService = storageService
    }

    public func getPuzzle(difficulty: String) async throws -> SudokuBoard {
        // TODO: fetch from API and map to SudokuBoard
        throw NSError(domain: "SudokuRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not implemented"])
    }

    public func saveGame(id: String, board: SudokuBoard) async throws {
        // TODO: encode board and save via storageService
        throw NSError(domain: "SudokuRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not implemented"])
    }

    public func loadGame(id: String) async throws -> SudokuBoard? {
        // TODO: load data and decode to SudokuBoard
        throw NSError(domain: "SudokuRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not implemented"])
    }
}
