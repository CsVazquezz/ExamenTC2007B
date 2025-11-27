//
//  HomeView.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import SwiftUI

public struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        // TODO: Implement UI - difficulty selection and start button
        Text("Home View - select difficulty")
    }
}
