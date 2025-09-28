//
//  GalleryViewModelFactory.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

protocol PhotoDetailViewModelFactory {
    func make(photo: FlickrPhoto) -> PhotoDetailViewModel
}

struct PhotoDetailViewModelFactoryImpl: PhotoDetailViewModelFactory {
    let getPhotoInfoUseCase: GetPhotoInfoUseCase

    func make(photo: FlickrPhoto) -> PhotoDetailViewModel {
        PhotoDetailViewModel(
            getPhotoInfoUseCase: getPhotoInfoUseCase,
            photo: photo
        )
    }
}
