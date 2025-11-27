//
//  SudokuCellView.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import SwiftUI

public struct SudokuCellView: View {
    public var cell: SudokuCell
    public var onSelect: ((SudokuCell) -> Void)?

    public init(cell: SudokuCell, onSelect: ((SudokuCell) -> Void)? = nil) {
        self.cell = cell
        self.onSelect = onSelect
    }

    public var body: some View {
        // TODO: Implement cell UI
        Text(cell.value.map { String($0) } ?? " ")
    }
}
