//
//  SudokuAPIService.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation

// Data layer - Network

public protocol SudokuAPIServiceProtocol {
    func fetchPuzzle(difficulty: String) async throws -> APIPuzzleDTO
}

public final class SudokuAPIService: SudokuAPIServiceProtocol {
    private let apiKey: String
    private let baseURL: URL
    private let session: URLSession

    public init(apiKey: String, baseURL: URL = URL(string: "https://api.api-ninjas.com/v1/sudoku")!, session: URLSession = .shared) {
        self.apiKey = apiKey
        self.baseURL = baseURL
        self.session = session
    }

    public func fetchPuzzle(difficulty: String) async throws -> APIPuzzleDTO {
        // TODO: Implement network request using X-Api-Key header
        // Example header: ["X-Api-Key": apiKey]
        throw NSError(domain: "SudokuAPIService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not implemented"])
    }
}
