//
//  SearchPhotosUseCase.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//


import Foundation

protocol SearchPhotosUseCase {
    func execute(text: String, page: Int, perPage: Int) async throws -> FlickrSearchResult
}

class SearchPhotosUseCaseImpl: SearchPhotosUseCase {
    private let repository: FlickrRepository

    init(repository: FlickrRepository) {
        self.repository = repository
    }

    func execute(text: String, page: Int, perPage: Int) async throws -> FlickrSearchResult {
        let result = try await repository.searchPhotos(text: text, page: page, perPage: perPage)
        if result.photos.isEmpty {
            throw CustomError(message: "No photos found.")
        }
        return result
    }
}
