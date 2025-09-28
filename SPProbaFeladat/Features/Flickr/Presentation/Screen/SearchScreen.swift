//
//  SearchScreen.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

import SwiftUI

struct SearchScreen: View {
    @EnvironmentObject var di: FlickrDIContainer
    
    var body: some View {
        SearchView(viewModel: di.searchViewModelFactory.make())
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(.systemBackground), for: .navigationBar)
    }
}
