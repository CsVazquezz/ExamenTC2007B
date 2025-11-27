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
    @Published public var isLoading: Bool = false

    private let repository: SudokuRepositoryProtocol

    public var repositoryProvider: SudokuRepositoryProtocol { repository }

    public init(repository: SudokuRepositoryProtocol) {
        self.repository = repository
    }

    public func startGame() async throws -> SudokuBoard {
        self.isLoading = true
        defer { self.isLoading = false }
        let board = try await repository.getPuzzle(difficulty: selectedDifficulty)
        return board
    }
}
