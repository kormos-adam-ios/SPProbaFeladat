//
//  PhotoDetailViewModel.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

import Foundation
import Combine
import SwiftUI

@MainActor
class PhotoDetailViewModel: ObservableObject {
    private let getPhotoInfoUseCase: GetPhotoInfoUseCase
    private let photo: FlickrPhoto
    @Published var info: FlickrPhotoInfo
   
    init(getPhotoInfoUseCase: GetPhotoInfoUseCase, photo: FlickrPhoto) {
        self.getPhotoInfoUseCase = getPhotoInfoUseCase
        self.photo = photo
        self.info = FlickrPhotoInfo(id: photo.id, server: photo.server, secret: photo.secret)
    }
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var downloadedImage: ImageWithURL? = nil
    
    
    func load() {
        Task {
            isLoading = true
            do {
                let info = try await getPhotoInfoUseCase.execute(photoId: photo.id, secret: photo.secret)
                self.info = info
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    func imageTapped() {
        Task {
            let image = try? await info.largeURL?.toKingfisherIdentifiableImage()
            if let image {
                await MainActor.run {
                    downloadedImage = image
                }
            }
        }
    }
}
