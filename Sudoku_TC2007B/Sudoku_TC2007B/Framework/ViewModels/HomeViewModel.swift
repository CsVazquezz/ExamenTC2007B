//
//  HomeViewModel.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation
import Combine

@MainActor
public class HomeViewModel: ObservableObject {
    @Published public var selectedDifficulty: String = "easy"

    private let repository: SudokuRepository

    public init(repository: SudokuRepository) {
        self.repository = repository
    }

    public func startGame() async throws -> SudokuBoard {
        // TODO: call repository.getPuzzle(difficulty:)
        throw NSError(domain: "HomeViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not implemented"])
    }
}
