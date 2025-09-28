//
//  FlickrPhotoInfoEndpoint.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

import Foundation


struct FlickrPhotoInfoEndpoint: Endpoint {
    let photoId: String
    let secret: String
    let apiKey: String
    let baseURL: URL = FlickrEndpointConstants.baseURL
    let path: String = FlickrEndpointConstants.path
    let method: HTTPMethod = .get
    var queryItems: [URLQueryItem] {
        get {
            FlickrEndpointConstants.commonQueryItems +
            [
                URLQueryItem(name: "method", value: "flickr.photos.getInfo"),
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "photo_id", value: photoId),
                URLQueryItem(name: "secret", value: secret)
            ]
        }
        
    }
}
