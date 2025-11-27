//
//  APIDTOs.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation

// DTOs for API responses

public struct SudokuResponseDTO: Codable {
    // The API returns a matrix where empty cells are null -> use [[Int?]]
    public let puzzle: [[Int?]]?
    public let solution: [[Int?]]?

    enum CodingKeys: String, CodingKey {
        case puzzle
        case solution
        case newboard
    }

    public init(puzzle: [[Int?]]? = nil, solution: [[Int?]]? = nil) {
        self.puzzle = puzzle
        self.solution = solution
    }

    public nonisolated init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let p = try? container.decode([[Int?]].self, forKey: .puzzle) {
            self.puzzle = p
        } else if let p = try? container.decode([[Int?]].self, forKey: .newboard) {
            self.puzzle = p
        } else {
            self.puzzle = nil
        }
        self.solution = try? container.decodeIfPresent([[Int?]].self, forKey: .solution)
    }

    public nonisolated func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(puzzle, forKey: .puzzle)
        try container.encodeIfPresent(solution, forKey: .solution)
    }
}
