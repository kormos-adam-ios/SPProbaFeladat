//
//  RequestBuilder.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//


import Foundation

struct RequestBuilder {
    static func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = endpoint.baseURL.scheme
        components.host = endpoint.baseURL.host
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        return request
    }
}
