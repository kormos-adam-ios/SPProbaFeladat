//
//  FlickrPhoto.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 25..
//
import Foundation

struct FlickrPhoto {
    let id: String
    let server: String
    let secret: String
    var page: Int?
    
    var imageName: String {
        "\(server)/\(id)_\(secret)"
    }
    
    /// 150x150
    var smallSquareURLString: String {
        "https://live.staticflickr.com/\(imageName)_q.jpg"
    }
    
    var smallSquareURL: URL? {
        URL(string: smallSquareURLString)
    }
    
    var uniqueIDWithPage: String {
        let page = page ?? -1
        return imageName + "_\(page)"
    }
}
