//
//  GalleryViewModel.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 26..
//

import Foundation
import Combine

@MainActor
class GalleryViewModel: ObservableObject {
    private let searchPhotosUseCase: SearchPhotosUseCase
    private let getLastSearchTextUseCase: GetLastSearchTextUseCase
    
    init(searchPhotosUseCase: SearchPhotosUseCase, getLastSearchTextUseCase: GetLastSearchTextUseCase) {
        self.searchPhotosUseCase = searchPhotosUseCase
        self.getLastSearchTextUseCase = getLastSearchTextUseCase
    }
    
    @Published var images: [FlickrPhoto] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    private var currentPage: Int = 1
    private var totalPages: Int = 0
    var searchText: String = ""
    private var currentSearchTask: Task<Void, Never>? = nil
    
    func refresh(){
        errorMessage = nil
        currentSearchTask?.cancel()
        currentPage = 1
        images = []
        
        currentSearchTask = Task {
            guard currentSearchTask?.isCancelled == false else { return }
            await searchForPictures(with: currentPage)
        }
    }
    
    func search() {
        let lastSearchText = getLastSearchTextUseCase.execute()
        if lastSearchText == searchText { return }
    
        searchText = lastSearchText
        refresh()
    }
    
    func loadNextPageIfNeeded() {
        guard !isLoading, currentPage < totalPages else { return }
        currentPage += 1
        Task {
            await searchForPictures(with: currentPage)
        }
    }
    
    private func searchForPictures(with page: Int = 1) async {
        
        defer {
            isLoading = false
        }
        
        isLoading = true
        do {
            let searchResult = try await searchPhotosUseCase.execute(text: searchText, page: page, perPage: 20)
            totalPages = searchResult.totalPages
            if page == 1 {
                images = searchResult.photos
            } else {
                images.append(contentsOf: searchResult.photos)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
