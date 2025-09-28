//
//  GalleryViewModelFactory.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

protocol SearchViewModelFactory {
    func make() -> SearchViewModel
}

struct SearchViewModelFactoryImpl: SearchViewModelFactory {
    let getSearchHistoryUseCase: GetSearchHistoryUseCase
    let addSearchTextUseCase: AddSearchTextUseCase

    func make() -> SearchViewModel {
        SearchViewModel(
            getSerachHistoryUseCase: getSearchHistoryUseCase,
            addSearchTextUseCase: addSearchTextUseCase
        )
    }
}
