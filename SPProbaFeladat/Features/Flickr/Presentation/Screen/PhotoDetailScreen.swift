//
//  PhotoDetailScreen.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

import SwiftUI

struct PhotoDetailScreen: View {
    let photo: FlickrPhoto
    @EnvironmentObject var di: FlickrDIContainer

    var body: some View {
        PhotoDetailView(viewModel: di.photoDetailViewModelFactory.make(photo: photo))
            .navigationTitle("Detail")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbarBackground(Color(.systemBackground), for: .navigationBar)
    }
}
