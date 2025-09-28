//
//  PhotosRepositoryImpl.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//

import Foundation

class FlickrRepositoryImpl: FlickrRepository {
  
    private let remoteDataSource: FlickrRemoteDataSource

    init(remoteDataSource: FlickrRemoteDataSource = FlickrRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func searchPhotos(text: String, page: Int, perPage: Int) async throws -> FlickrSearchResult {
        return try await remoteDataSource.searchPhotos(text: text, page: page, perPage: perPage).toDomain()
    }
    
    func photoInfo(photoId: String, secret: String) async throws -> FlickrPhotoInfo {
        return try await remoteDataSource.photoInfo(photoId: photoId, secret: secret).toDomain()
    }
}
