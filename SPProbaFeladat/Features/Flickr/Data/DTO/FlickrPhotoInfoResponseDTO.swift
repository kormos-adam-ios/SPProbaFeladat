//
//  FlickrPhotoInfoResponseDTO.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//


import Foundation

struct FlickrPhotoInfoResponseDTO: Decodable {
    let photo: FlickrPhotoInfoDTO
    
    func toDomain() -> FlickrPhotoInfo {
        let tags = photo.tags?.tag.map { $0.content}
        
        return FlickrPhotoInfo(id: photo.id, server: photo.server, secret: photo.secret, dateUploadedUnixTime: photo.dates?.posted, title: photo.title?.content, description: photo.description?.content, ownerName: photo.owner?.realname, ownerUsername: photo.owner?.username, tags: tags, views: photo.views)
    }
}
