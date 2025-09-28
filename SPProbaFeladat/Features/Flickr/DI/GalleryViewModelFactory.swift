//
//  GalleryViewModelFactory.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

protocol GalleryViewModelFactory {
    func make() -> GalleryViewModel
}

struct GalleryViewModelFactoryImpl: GalleryViewModelFactory {
    let searchPhotosUseCase: SearchPhotosUseCase
    let getLastSearchTextUseCase: GetLastSearchTextUseCase

    func make() -> GalleryViewModel {
        GalleryViewModel(
            searchPhotosUseCase: searchPhotosUseCase,
            getLastSearchTextUseCase: getLastSearchTextUseCase
        )
    }
}
