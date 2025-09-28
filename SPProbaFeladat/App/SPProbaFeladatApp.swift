//
//  SPProbaFeladatApp.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 25..
//

import SwiftUI

@main
struct SPProbaFeladatApp: App {
    
    @StateObject private var flickrDIContainer = FlickrDIContainer()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GalleryScreen()
            }
            .environmentObject(flickrDIContainer)
        }
    }
}
