//
//  Endpoint.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//


import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}
