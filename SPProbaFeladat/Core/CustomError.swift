//
//  CustomError.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//

import Foundation

struct CustomError: LocalizedError {
    let message: String
    
    var errorDescription: String? { message }
}
