//
//  GetSearchHistoryUseCase.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//


import Foundation

protocol GetSearchHistoryUseCase {
    func execute() -> [String]
}

class GetSearchHistoryUseCaseImpl: GetSearchHistoryUseCase {
    private let repository: SearchHistoryRepository
    
    init(repository: SearchHistoryRepository) {
        self.repository = repository
    }
    
    func execute() -> [String] {
        repository.getHistory().reversed()
    }
}
