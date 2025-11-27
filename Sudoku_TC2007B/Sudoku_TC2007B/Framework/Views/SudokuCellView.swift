//
//  SudokuCellView.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import SwiftUI

public struct SudokuCellView: View {
    public var cell: SudokuCell
    public var isSelected: Bool
    public var onSelect: ((SudokuCell) -> Void)?

    public init(cell: SudokuCell, isSelected: Bool = false, onSelect: ((SudokuCell) -> Void)? = nil) {
        self.cell = cell
        self.isSelected = isSelected
        self.onSelect = onSelect
    }

    public var body: some View {
        let text = cell.value.map { String($0) } ?? ""
        ZStack {
            Rectangle()
                .foregroundColor(isSelected ? Color.yellow.opacity(0.3) : Color.white)
            Text(text)
                .font(.system(size: 20))
                .fontWeight(cell.isGiven ? .bold : .regular)
                .foregroundColor(cell.isGiven ? Color.black : Color.blue)
        }
        .aspectRatio(1, contentMode: .fit)
        .overlay(
            Rectangle().stroke(Color.gray, lineWidth: 0.5)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            onSelect?(cell)
        }
    }
}
