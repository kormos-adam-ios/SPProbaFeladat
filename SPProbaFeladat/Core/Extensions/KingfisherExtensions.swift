//
//  KingfisherExtensions.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

import SwiftUI
import Kingfisher

extension URL {
    func toKingfisherIdentifiableImage() async throws -> ImageWithURL {
        let image = try await toKingfisherlImage()
        return ImageWithURL(url: self, image: image)
    }
    
    func toKingfisherlImage() async throws -> Image {
        let result = try await KingfisherManager.shared.retrieveImage(with: self)
        return Image(uiImage: result.image)
    }
}

struct ImageWithURL: Hashable, Identifiable {
    var id: String { url.absoluteString }
    
    let url: URL
    let image: Image
    
    static func == (l: ImageWithURL, r: ImageWithURL) -> Bool { l.url == r.url }
    func hash(into h: inout Hasher) { h.combine(url) }
}
