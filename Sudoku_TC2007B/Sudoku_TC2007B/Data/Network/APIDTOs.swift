//
//  APIDTOs.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation

// DTOs for API responses

public struct APIPuzzleDTO: Codable {
    public let puzzle: [String]? // API may return different shapes; keep flexible
    public let solution: [String]?
    public let difficulty: String?

    public init(puzzle: [String]? = nil, solution: [String]? = nil, difficulty: String? = nil) {
        self.puzzle = puzzle
        self.solution = solution
        self.difficulty = difficulty
    }
}
