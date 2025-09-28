//
//  FlickrSearchEndpoint.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//

import Foundation

struct FlickrSearchEndpoint: Endpoint {
    let text: String
    let page: Int
    let perPage: Int
    let apiKey: String
    let baseURL: URL = FlickrEndpointConstants.baseURL
    let path: String = FlickrEndpointConstants.path
    let method: HTTPMethod = .get
    var queryItems: [URLQueryItem] {
        get {
            FlickrEndpointConstants.commonQueryItems +
            [
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "text", value: text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "\(perPage)")
            ]
        }
        
    }
}
