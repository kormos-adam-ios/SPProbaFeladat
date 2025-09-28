//
//  SearchViewModel.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 26..
//

import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    
    private let getSearchHistoryUseCase: GetSearchHistoryUseCase
    private let addSearchTextUseCase: AddSearchTextUseCase
    
    var history: [String] = []
    @Published var filteredHistory : [String]
    @Published var errorMessage : String?
    @Published var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                filteredHistory = history
            }
            else {
                let historySet = Set(history).filter({ item in
                    return item.removingAccents.contains(searchText.removingAccents)
                })
                filteredHistory = historySet.sorted()
            }
        }
    }

    init(getSerachHistoryUseCase: GetSearchHistoryUseCase, addSearchTextUseCase: AddSearchTextUseCase){
        self.addSearchTextUseCase = addSearchTextUseCase
        self.getSearchHistoryUseCase = getSerachHistoryUseCase
        history = getSearchHistoryUseCase.execute()
        filteredHistory = history
    }
    
    func search(_ text: String) async -> Bool {
        do {
            try addSearchTextUseCase.execute(text: text)
            return true
        } catch(let e) {
            errorMessage = e.localizedDescription
            return false
        }
    }
}

extension String {
    var removingAccents: String {
        folding(options: .diacriticInsensitive, locale: .current)
    }
}
