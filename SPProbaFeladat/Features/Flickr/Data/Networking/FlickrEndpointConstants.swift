//
//  FlickrConstants.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

import Foundation

struct FlickrEndpointConstants {
    static let baseURL = URL(string: "https://www.flickr.com")!
    static let path = "/services/rest/"
    static let commonQueryItems: [URLQueryItem] = [
        URLQueryItem(name: "format", value: "json"),
        URLQueryItem(name: "nojsoncallback", value: "1")
        ]
}
