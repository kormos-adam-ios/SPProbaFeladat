//
//  GalleryItemView.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 26..
//

import SwiftUI
import Kingfisher

struct GalleryItemView: View {
    let imageURL: URL?
    
    var body: some View {
        KFImage(imageURL)
            .resizable()
            .placeholder {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .aspectRatio(1, contentMode: .fit)
            }
            .aspectRatio(1, contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3)
    }
    
}


struct GalleryItemViewForNonSquareImage: View {
    let imageURLString: String
    
    var body: some View {
        Rectangle()
            .aspectRatio(1.0 , contentMode: .fill)
            .foregroundColor(.gray.opacity(0.3))
            .overlay {
                AsyncImage(url: URL(string: imageURLString)!) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(minHeight: 0, maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .clipped()
                }
                placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3)
    }
}

