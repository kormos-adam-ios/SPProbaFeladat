//
//  RemoveSearchTextUseCase.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//

protocol RemoveSearchTextUseCase {
    func execute(text: String)
}

class RemoveSearchTextUseCaseImpl: RemoveSearchTextUseCase {
    private let repository: SearchHistoryRepository
    
    init(repository: SearchHistoryRepository) {
        self.repository = repository
    }
    
    func execute(text: String) {
        repository.remove(text)
    }
}
