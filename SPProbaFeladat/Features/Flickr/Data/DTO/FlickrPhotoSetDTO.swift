//
//  FlickrPhotoSetDTO.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 25..
//


struct FlickrPhotoSetDTO: Decodable {
    let page: Int
    let pages: Int
    let total: Int
    let photo: [FlickrPhotoDTO]
}
