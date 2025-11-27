//
//  GameView.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import SwiftUI

public struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    public init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        // TODO: Implement game board UI
        Text("Game View - board goes here")
    }
}
