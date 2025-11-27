//
//  GameView.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import SwiftUI

public struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 9)

    public init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if case .loading = viewModel.state {
                    ProgressView()
                        .scaleEffect(1.5)
                }

                if let board = viewModel.board {
                    GeometryReader { geo in
                        let side = min(geo.size.width, geo.size.height)
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 0) {
                                ForEach(board.cells, id: \ .id) { cell in
                                    SudokuCellView(cell: cell, isSelected: viewModel.selectedCellID == cell.id) { selected in
                                        viewModel.cellSelected(selected)
                                    }
                                    .frame(width: side / 9, height: side / 9)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(height: 360)

                    // Numeric keyboard
                    VStack(spacing: 8) {
                        ForEach(0..<3) { row in
                            HStack(spacing: 8) {
                                ForEach(1 + row*3...3 + row*3, id: \ .self) { num in
                                    Button(action: {
                                        viewModel.numberEntered(num)
                                    }) {
                                        Text("\(num)")
                                            .frame(maxWidth: .infinity, minHeight: 44)
                                            .background(Color(UIColor.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                        HStack(spacing: 8) {
                            Button(action: { viewModel.numberEntered(0) }) {
                                Text("Borrar")
                                    .frame(maxWidth: .infinity, minHeight: 44)
                                    .background(Color.red.opacity(0.8))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            Button(action: { Task { await viewModel.loadNewPuzzle(difficulty: "easy") } }) {
                                Text("Nuevo Juego")
                                    .frame(maxWidth: .infinity, minHeight: 44)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                } else {
                    Text("No board loaded")
                        .foregroundColor(.secondary)
                    Button("Nuevo Juego") {
                        Task { await viewModel.loadNewPuzzle(difficulty: "easy") }
                    }
                }

                Spacer()
            }
            .padding()
            .navigationBarTitle("Sudoku", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
