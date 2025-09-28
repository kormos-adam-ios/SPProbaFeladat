//
//  SearchHistoryRepository.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//


protocol SearchHistoryRepository {
    func getHistory() -> [String]
    func add(_ text: String)
    func remove(_ text: String)
}
