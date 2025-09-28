//
//  GalleryScreen.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

import SwiftUI

struct GalleryScreen: View {
    @EnvironmentObject var di: FlickrDIContainer
    
    var body: some View {
        GalleryView(viewModel: di.galleryViewModelFactory.make())
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SearchScreen()) {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .toolbarBackground(Color(.systemBackground), for: .navigationBar)
    }
}
