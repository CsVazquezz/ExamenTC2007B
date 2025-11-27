//
//  GameStorageService.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation

public protocol GameStorageServiceProtocol {
    func saveGame(id: String, boardData: Data) async throws
    func loadGame(id: String) async throws -> Data?
    func deleteGame(id: String) async throws
}

public final class GameStorageService: GameStorageServiceProtocol {
    private let fileManager: FileManager
    private let folderURL: URL

    public init(folderURL: URL? = nil, fileManager: FileManager = .default) {
        self.fileManager = fileManager
        if let folderURL = folderURL {
            self.folderURL = folderURL
        } else {
            self.folderURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("SudokuGames")
        }
        // TODO: create folder if needed
    }

    public func saveGame(id: String, boardData: Data) async throws {
        // TODO: Implement saving logic
        throw NSError(domain: "GameStorageService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not implemented"])
    }

    public func loadGame(id: String) async throws -> Data? {
        // TODO: Implement loading logic
        throw NSError(domain: "GameStorageService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not implemented"])
    }

    public func deleteGame(id: String) async throws {
        // TODO: Implement delete logic
        throw NSError(domain: "GameStorageService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not implemented"])
    }
}
