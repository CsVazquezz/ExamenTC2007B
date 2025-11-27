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
    @Published public var board: SudokuBoard? = nil
    @Published public var selectedCellID: UUID? = nil

    private let repository: SudokuRepositoryProtocol
    private let validator: SudokuValidatorProtocol

    public init(repository: SudokuRepositoryProtocol, validator: SudokuValidatorProtocol) {
        self.repository = repository
        self.validator = validator
    }

    public func loadNewPuzzle(difficulty: String) async {
        self.state = .loading
        do {
            let board = try await repository.getPuzzle(difficulty: difficulty)
            self.board = board
            self.state = .success(board)
        } catch {
            self.state = .error(error)
        }
    }

    public func cellSelected(_ cell: SudokuCell) {
        // only allow selection of non-given cells
        guard !cell.isGiven else { return }
        self.selectedCellID = cell.id
    }

    public func numberEntered(_ number: Int) {
        guard var currentBoard = board, let selectedID = selectedCellID else { return }
        guard let selectedCell = currentBoard.cells.first(where: { $0.id == selectedID }) else { return }
        // ignore changes to given cells
        if selectedCell.isGiven { return }

        // treat 0 as delete
        let newValue: Int? = (number == 0) ? nil : number

        // create updated board immutably
        let newBoard = currentBoard.update(cell: selectedCell, newValue: newValue)
        self.board = newBoard
        self.state = .success(newBoard)
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
