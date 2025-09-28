//
//  FlickrRepository.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//


protocol FlickrRepository {
    func searchPhotos(text: String, page: Int, perPage: Int) async throws -> FlickrSearchResult
    func photoInfo(photoId: String, secret: String) async throws -> FlickrPhotoInfo
}
