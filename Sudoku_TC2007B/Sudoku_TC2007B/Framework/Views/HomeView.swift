//
//  HomeView.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import SwiftUI

public struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    @State private var navigateToGame: Bool = false
    @State private var gameViewModel: GameViewModel? = nil
    @State private var errorMessage: String? = nil

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Select difficulty")
                    .font(.headline)

                Picker("Difficulty", selection: $viewModel.selectedDifficulty) {
                    Text("Easy").tag("easy")
                    Text("Medium").tag("medium")
                    Text("Hard").tag("hard")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if viewModel.isLoading {
                    ProgressView()
                }

                Button(action: {
                    Task {
                        do {
                            let board = try await viewModel.startGame()
                            let validator = SudokuValidator()
                            let gvm = GameViewModel(repository: viewModel.repositoryProvider, validator: validator)
                            gvm.board = board
                            self.gameViewModel = gvm
                            self.navigateToGame = true
                        } catch {
                            // Fallback demo board
                            errorMessage = "Error loading from API: \(error.localizedDescription). Using local demo board."
                            var cells: [SudokuCell] = []
                            for r in 0..<9 {
                                for c in 0..<9 {
                                    if r == c || (r + c) % 4 == 0 {
                                        let val = ((r * 3 + r / 3 + c) % 9) + 1
                                        cells.append(SudokuCell(row: r, col: c, value: val, isGiven: true))
                                    } else {
                                        cells.append(SudokuCell(row: r, col: c, value: nil, isGiven: false))
                                    }
                                }
                            }
                            let demoBoard = SudokuBoard(size: 9, cells: cells)
                            let validator = SudokuValidator()
                            let gvm = GameViewModel(repository: viewModel.repositoryProvider, validator: validator)
                            gvm.board = demoBoard
                            self.gameViewModel = gvm
                            self.navigateToGame = true
                        }
                    }
                }) {
                    Text("Start Game")
                        .bold()
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(viewModel.isLoading ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .disabled(viewModel.isLoading)

                if let err = errorMessage {
                    Text(err).foregroundColor(.red).multilineTextAlignment(.center)
                }

                NavigationLink(destination: Group {
                    if let gvm = gameViewModel {
                        GameView(viewModel: gvm)
                    } else {
                        EmptyView()
                    }
                }, isActive: $navigateToGame) {
                    EmptyView()
                }

                Spacer()
            }
            .navigationTitle("Sudoku")
            .padding()
            .onAppear {
                print("[HomeView] appeared - difficulty=\(viewModel.selectedDifficulty)")
            }
        }
    }
}
