//
//  GetPhotoInfoUseCase.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//


import Foundation

protocol GetPhotoInfoUseCase {
    func execute(photoId: String, secret: String) async throws -> FlickrPhotoInfo
}

class GetPhotoInfoUseCaseImpl: GetPhotoInfoUseCase {
    private let repository: FlickrRepository

    init(repository: FlickrRepository) {
        self.repository = repository
    }

    func execute(photoId: String, secret: String) async throws -> FlickrPhotoInfo {
        return try await repository.photoInfo(photoId: photoId, secret: secret)
    }
}
