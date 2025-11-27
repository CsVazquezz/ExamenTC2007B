//
//  SudokuAPIService.swift
//  Sudoku_TC2007B
//
//  Created by Carlos Martinez Vazquez on 27/11/25.
//

import Foundation
import Alamofire

// Data layer - Network

public protocol SudokuAPIServiceProtocol {
    func fetchSudoku(difficulty: String, width: Int, height: Int) async throws -> SudokuResponseDTO
}

public final class SudokuAPIService: SudokuAPIServiceProtocol {
    private let apiKey: String
    private let baseURL: String = "https://api.api-ninjas.com/v1/sudokugenerate"
    private let session: Session

    public init(apiKey: String = "wLVPN1zV08lJYF7uXqgyPw==zVwp6TlVcAO1NLUf", session: Session = .default) {
        self.apiKey = apiKey
        self.session = session
    }

    public func fetchSudoku(difficulty: String, width: Int, height: Int) async throws -> SudokuResponseDTO {
        // Create a request id for tracing
        let requestId = UUID().uuidString

        // Prepare headers and params
        var headers: HTTPHeaders = ["x-api-key": apiKey]
        headers.add(name: "x-request-id", value: requestId)

        let parameters: Parameters = ["width": width, "height": height, "difficulty": difficulty]

        // Log request details for debugging
        print("[SudokuAPIService] RequestId=\(requestId) Fetching sudoku -> URL=\(baseURL) params=\(parameters) headers=\(headers)")

        let request = session.request(baseURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()

        let response = await request.serializingDecodable(SudokuResponseDTO.self).response

        // Log low-level response details
        if let httpResponse = response.response {
            let status = httpResponse.statusCode
            print("[SudokuAPIService] RequestId=\(requestId) HTTP Status=\(status)")
            // log response headers
            print("[SudokuAPIService] RequestId=\(requestId) Response Headers=\(httpResponse.allHeaderFields)")
        } else {
            print("[SudokuAPIService] RequestId=\(requestId) No HTTPURLResponse received")
        }

        // Log raw body if available
        if let data = response.data, data.count > 0 {
            if let s = String(data: data, encoding: .utf8) {
                print("[SudokuAPIService] RequestId=\(requestId) Response Body=\n\(s)")
            } else {
                print("[SudokuAPIService] RequestId=\(requestId) Response Body (binary, \(data.count) bytes)")
            }
        } else {
            print("[SudokuAPIService] RequestId=\(requestId) Response Body is empty")
        }

        if let error = response.error {
            // If we have an AFError we can include more details
            print("[SudokuAPIService] RequestId=\(requestId) Error=\(error)")

            // If the server returned 400, attach diagnostic info
            if let status = response.response?.statusCode, status == 400 {
                let bodyString: String = {
                    if let d = response.data, let s = String(data: d, encoding: .utf8) { return s }
                    return "<no body>"
                }()
                let message = "API returned 400 Bad Request. requestId=\(requestId) status=400 body=\(bodyString)"
                print("[SudokuAPIService] RequestId=\(requestId) Diagnostic=\(message)")
                throw NSError(domain: "SudokuAPIService", code: 400, userInfo: [NSLocalizedDescriptionKey: message])
            }

            throw error
        }

        guard let value = response.value else {
            // No decoded value but no error — create a debug message
            let msg = "No value decoded from response. requestId=\(requestId)"
            print("[SudokuAPIService] RequestId=\(requestId) \(msg)")
            throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
        }

        print("[SudokuAPIService] RequestId=\(requestId) Success - decoded SudokuResponseDTO")
        return value
    }
}
