//
//  FlickrDIContainer.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

import Combine

@MainActor
final class FlickrDIContainer: ObservableObject {
    
    let galleryViewModelFactory: GalleryViewModelFactory
    let searchViewModelFactory: SearchViewModelFactory
    let photoDetailViewModelFactory: PhotoDetailViewModelFactory

    init() {
        let flickrRepo: FlickrRepository = FlickrRepositoryImpl()
        let searchHistoryRepo: SearchHistoryRepository = SearchHistoryRepositoryImpl()

        searchViewModelFactory = SearchViewModelFactoryImpl(getSearchHistoryUseCase: GetSearchHistoryUseCaseImpl(repository: searchHistoryRepo), addSearchTextUseCase: AddSearchTextUseCaseImpl(repository: searchHistoryRepo))
        galleryViewModelFactory = GalleryViewModelFactoryImpl(searchPhotosUseCase: SearchPhotosUseCaseImpl(repository: flickrRepo), getLastSearchTextUseCase: GetLastSearchTextUseCaseImpl(repository: searchHistoryRepo))
        photoDetailViewModelFactory = PhotoDetailViewModelFactoryImpl(getPhotoInfoUseCase: GetPhotoInfoUseCaseImpl(repository: flickrRepo))
    }
}
