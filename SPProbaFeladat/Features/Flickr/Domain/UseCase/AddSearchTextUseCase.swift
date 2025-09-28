//
//  AddSearchTextUseCase.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//


import Foundation

protocol AddSearchTextUseCase {
    func execute(text: String) throws
}

class AddSearchTextUseCaseImpl: AddSearchTextUseCase  {
    private let repository: SearchHistoryRepository
    
    init(repository: SearchHistoryRepository) {
        self.repository = repository
    }
    
    func execute(text: String) throws {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            throw CustomError(message: "Invalid search text")
        }
        repository.add(trimmed)
    }
}
