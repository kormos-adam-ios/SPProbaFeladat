//
//  HTTPClient.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//

import Foundation

protocol HTTPClientProtocol {
    func send<T: Decodable & Sendable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T
    func sendData(_ endpoint: Endpoint) async throws -> Data
}

struct HTTPClient: HTTPClientProtocol {
    func send<T: Decodable & Sendable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        let data = try await sendData(endpoint)
        return try JSONDecoder().decode(T.self, from: data)
    }

    func sendData(_ endpoint: Endpoint) async throws -> Data {
        let request = try RequestBuilder.buildRequest(from: endpoint)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
