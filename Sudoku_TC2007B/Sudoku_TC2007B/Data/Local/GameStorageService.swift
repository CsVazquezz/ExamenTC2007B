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
        // create folder if needed
        if !fileManager.fileExists(atPath: self.folderURL.path) {
            do {
                try fileManager.createDirectory(at: self.folderURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                // ignore creation error here; operations will throw if needed
            }
        }
    }

    public func saveGame(id: String, boardData: Data) async throws {
        let fileURL = folderURL.appendingPathComponent("\(id).json")
        try await Task.detached(priority: .utility) {
            try boardData.write(to: fileURL, options: .atomic)
        }.value
    }

    public func loadGame(id: String) async throws -> Data? {
        let fileURL = folderURL.appendingPathComponent("\(id).json")
        return try await Task.detached(priority: .utility) {
            if self.fileManager.fileExists(atPath: fileURL.path) {
                return try Data(contentsOf: fileURL)
            }
            return nil
        }.value
    }

    public func deleteGame(id: String) async throws {
        let fileURL = folderURL.appendingPathComponent("\(id).json")
        try await Task.detached(priority: .utility) {
            if self.fileManager.fileExists(atPath: fileURL.path) {
                try self.fileManager.removeItem(at: fileURL)
            }
        }.value
    }
}
