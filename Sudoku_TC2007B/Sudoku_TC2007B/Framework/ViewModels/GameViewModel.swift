//
//  GameViewModel.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
public class GameViewModel: ObservableObject {
    public enum State {
        case idle
        case loading
        case success(SudokuBoard)
        case error(Error)
        case offline
    }

    @Published public private(set) var state: State = .idle

    private let repository: SudokuRepositoryProtocol
    private let validator: SudokuValidatorProtocol

    public init(repository: SudokuRepositoryProtocol, validator: SudokuValidatorProtocol) {
        self.repository = repository
        self.validator = validator
    }

    public func loadNewPuzzle(difficulty: String) async {
        // TODO: call repository.getPuzzle(difficulty:) and update state
    }

    public func verify(board: SudokuBoard) async {
        // TODO: delegate to validator.validate(board:)
    }

    public func save(board: SudokuBoard) async {
        // TODO: call repository.saveGame(id:board:)
    }

    public func load(id: String) async {
        // TODO: call repository.loadGame(id:)
    }
}
