//
//  FlickrPhotoInfo.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//


import Foundation

struct FlickrPhotoInfo {
    let id: String
    let server: String
    let secret: String
    var dateUploadedUnixTime: String? = nil
    var title: String? = nil
    var description: String? = nil
    var ownerName: String? = nil
    var ownerUsername: String? = nil
    var tags: [String]? = nil
    var views: String? = nil
   
    
    var imageName: String {
        "\(server)/\(id)_\(secret)"
    }
    
    var mediumURLString: String {
        "https://live.staticflickr.com/\(imageName).jpg"
    }
    
    var mediumURL: URL? {
        URL(string: mediumURLString)
    }
    
    /// 150x150
    var smallSquareURLString: String {
        "https://live.staticflickr.com/\(imageName)_q.jpg"
    }
    
    var smallSquareURL: URL? {
        URL(string: smallSquareURLString)
    }
    
    var largeURLString: String {
        "https://live.staticflickr.com/\(imageName)_b.jpg"
    }
    
    var largeURL: URL? {
        URL(string: largeURLString)
    }
    
    
    var dateString: String? {
        guard let dateUploadedUnixTime, let timestamp = Double(dateUploadedUnixTime) else { return nil }
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    var formattedViews: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let views, let intView = Int(views), let formattedNumber = numberFormatter.string(from: NSNumber(value: intView)) {
            return formattedNumber
        } else {
            return self.views ?? ""
        }
    }
}
