//
//  Secrets.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 25..
//

import Foundation

enum Secrets {
    static func readSecret(resourceName: String, key: String) -> String? {
        guard
            let url = Bundle.main.url(forResource: resourceName, withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let dict = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
            let key = dict[key] as? String
        else {
            return nil
        }
        return key
    }
    

}
