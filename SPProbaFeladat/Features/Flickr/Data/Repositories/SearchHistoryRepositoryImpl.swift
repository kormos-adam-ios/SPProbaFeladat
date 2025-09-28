//
//  SearchHistoryRepositoryImpl.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//

import Foundation

class SearchHistoryRepositoryImpl: SearchHistoryRepository {
    
    private var history: [String] = ["dog"]

    init() {
        self.history = UserDefaults.standard.array(forKey: "searchHistory") as? [String] ?? ["dog"]
    }
    
    func remove(_ text: String) {
        history.removeAll { item in
            item == text
        }
        UserDefaults.standard.set(history, forKey: "searchHistory")
    }
     
    func add(_ text: String) {
        if history.last == text { return }
        history.removeAll { $0 == text }
        history.append(text)
        if history.count > 20 {
            history.removeFirst(history.count - 20)
        }
        UserDefaults.standard.set(history, forKey: "searchHistory")
    }
    
    func getHistory() -> [String] {
        history
    }
}
