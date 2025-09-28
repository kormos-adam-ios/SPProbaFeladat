//
//  GetLastSearchTextUseCase.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//


import Foundation

protocol GetLastSearchTextUseCase {
    func execute() -> String
}

class GetLastSearchTextUseCaseImpl: GetLastSearchTextUseCase {
    private let repository: SearchHistoryRepository
    
    init(repository: SearchHistoryRepository) {
        self.repository = repository
    }
    
    func execute() -> String {
        repository.getHistory().last!
    }
}
