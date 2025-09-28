//
//  FlickrResponseDTO.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 25..
//


struct FlickrResponseDTO: Decodable {
    let photos: FlickrPhotoSetDTO
    
    func toDomain() -> FlickrSearchResult {
        FlickrSearchResult(totalPages: photos.pages, photos: photos.photo.map {
            FlickrPhoto(id: $0.id, server: $0.server, secret: $0.secret, page: photos.page)
        })
    }
}
