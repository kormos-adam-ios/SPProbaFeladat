//
//  FlickrPhotoInfoDTO.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//


import Foundation

struct FlickrPhotoInfoDTO: Decodable {
    let id: String
    let secret: String
    let server: String
    let farm: Int
    let views: String?
    let owner: FlickrPhotoInfoOwnerDTO?
    let title: FlickrPhotoInfoTitleDTO?
    let description: FlickrPhotoInfoDescriptionDTO?
    let dates: FlickrPhotoInfoDatesDTO?
    let tags: FlickrPhotoTagRootDTO?
}

struct FlickrPhotoInfoOwnerDTO: Decodable {
    let username: String
    let realname: String
}

struct FlickrPhotoInfoTitleDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
    
    let content: String
}

struct FlickrPhotoInfoDescriptionDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
    
    let content: String
}

struct FlickrPhotoInfoDatesDTO: Decodable {
    let posted: String
    let taken: String
}

struct FlickrPhotoTagRootDTO: Decodable {
    let tag: [FlickrPhotoTagDTO]
}

struct FlickrPhotoTagDTO: Decodable {
    let id: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case content = "_content"
    }
}
