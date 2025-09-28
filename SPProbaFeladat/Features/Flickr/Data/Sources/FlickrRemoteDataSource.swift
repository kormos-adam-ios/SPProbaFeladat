//
//  FlickrRemoteDataSource.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//

import Foundation

struct FlickrRemoteDataSource {
    private let httpClient: HTTPClientProtocol

    init(httpClient: HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }

    func searchPhotos(text: String, page: Int, perPage: Int) async throws -> FlickrResponseDTO {
        guard let apiKey = Secrets.readSecret(resourceName: "flickr_secret", key: "flickr_api_key") else {
            throw CustomError(message: "Flickr api key missing")
        }
        let endpoint = FlickrSearchEndpoint(text: text, page: page, perPage: perPage, apiKey: apiKey)
        let rawData = try await httpClient.sendData(endpoint)
        return try JSONDecoder().decode(FlickrResponseDTO.self, from: rawData)
    }
    
    func photoInfo(photoId: String, secret: String) async throws -> FlickrPhotoInfoResponseDTO {
        guard let apiKey = Secrets.readSecret(resourceName: "flickr_secret", key: "flickr_api_key") else {
            throw CustomError(message: "Flickr api key missing")
        }
        let endpoint = FlickrPhotoInfoEndpoint(photoId: photoId, secret: secret, apiKey: apiKey)
        let rawData = try await httpClient.sendData(endpoint)
        return try JSONDecoder().decode(FlickrPhotoInfoResponseDTO.self, from: rawData)
    }

    private func cleanFlickrResponse(_ data: Data) -> Data {
        guard let string = String(data: data, encoding: .utf8) else { return data }

        // Remove `jsonFlickrApi(` prefix and trailing `)` if present
        var cleaned = string
        if cleaned.hasPrefix("jsonFlickrApi(") {
            cleaned = String(cleaned.dropFirst("jsonFlickrApi(".count))
        }
        if cleaned.hasSuffix(")") {
            cleaned = String(cleaned.dropLast())
        }

        return cleaned.data(using: .utf8) ?? data
    }
}
