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

    struct SavedGameDTO: Codable {
        let board: SudokuBoard
        let difficulty: String?
        let savedAt: Date
    }

    public init(apiService: SudokuAPIServiceProtocol, storageService: GameStorageServiceProtocol) {
        self.apiService = apiService
        self.storageService = storageService
    }

    public func getPuzzle(difficulty: String) async throws -> SudokuBoard {
        // The external API expects subgrid dimensions (width/height) between 2 and 4.
        // For a standard 9x9 Sudoku, pass width=3 and height=3 (3x3 subgrids -> 9x9 board).
        let subgridWidth = 3
        let subgridHeight = 3
        let size = subgridWidth * subgridHeight // 9

        let dto = try await apiService.fetchSudoku(difficulty: difficulty, width: subgridWidth, height: subgridHeight)

        // Prefer dto.puzzle
        guard let matrix = dto.puzzle else {
            throw NSError(domain: "SudokuRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "API returned no puzzle data"])
        }

        // Map returned matrix to cells. Be tolerant of shapes: if rows/cols differ from expected size, adapt.
        var cells: [SudokuCell] = []
        for (r, row) in matrix.enumerated() {
            for (c, valueOpt) in row.enumerated() {
                // API may return null for empty cells; also handle 0 as empty
                let cellValue: Int?
                let isGiven: Bool
                if let v = valueOpt, v != 0 {
                    cellValue = v
                    isGiven = true
                } else {
                    cellValue = nil
                    isGiven = false
                }
                let cell = SudokuCell(row: r, col: c, value: cellValue, isGiven: isGiven, isError: false)
                cells.append(cell)
            }
        }

        // If API returned a different shape (e.g., flattened), handle fallback to create an empty 9x9 board
        if cells.isEmpty {
            // fallback: create empty board of size `size`
            for r in 0..<size {
                for c in 0..<size {
                    cells.append(SudokuCell(row: r, col: c, value: nil, isGiven: false))
                }
            }
        }

        let board = SudokuBoard(size: size, cells: cells, difficulty: difficulty)
        return board
    }

    public func saveGame(id: String, board: SudokuBoard) async throws {
        let dto = SavedGameDTO(board: board, difficulty: board.difficulty, savedAt: Date())
        let data = try JSONEncoder().encode(dto)
        try await storageService.saveGame(id: id, boardData: data)
    }

    public func loadGame(id: String) async throws -> SudokuBoard? {
        guard let data = try await storageService.loadGame(id: id) else { return nil }
        let dto = try JSONDecoder().decode(SavedGameDTO.self, from: data)
        // Ensure board contains difficulty
        var board = dto.board
        board.difficulty = dto.difficulty
        return board
    }
}
