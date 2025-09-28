//
//  GalleryView.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 25..
//

import SwiftUI

struct GalleryView: View {
    @StateObject var viewModel: GalleryViewModel
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    var body: some View {
        ScrollView {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .padding()
            }
            else {
                LazyVGrid(columns: gridItems, spacing: spacing) {
                    //itt uniqueIdWithPage van, ami még megoldás lenne: \.offset (hiszen nem rendezem, csak appendelem, de erre támaszkodni luxus)
                    ForEach(Array(viewModel.images.enumerated()), id: \.element.uniqueIDWithPage) { index, image in
                        NavigationLink(destination: PhotoDetailScreen(photo: image)) {
                            GalleryItemView(imageURL: image.smallSquareURL)
                                .onAppear {
                                    if index == viewModel.images.count - 5 {
                                        viewModel.loadNextPageIfNeeded()
                                    }
                                }
                        }
                    }
                }
                .padding()
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .controlSize(.large)
                       .frame(maxWidth: .infinity)
                }
            }
        }
        .refreshable {
            viewModel.refresh()
        }
        .frame(maxWidth: .infinity)
        .scrollDismissesKeyboard(.immediately)
        .navigationTitle(viewModel.searchText)
        .onAppear {
            viewModel.search()
        }
    }
    
    private let spacing: CGFloat = 15
    
    var gridItems: [GridItem] {
        let isLandscape = verticalSizeClass == .compact
        
        if isLandscape || UIDevice.current.userInterfaceIdiom == .pad {
            return [GridItem(.flexible(minimum: 1, maximum: .infinity), spacing: spacing),
                    GridItem(.flexible(minimum: 1, maximum: .infinity), spacing: spacing),
                    GridItem(.flexible(minimum: 1, maximum: .infinity), spacing: spacing),
                    GridItem(.flexible(minimum: 1, maximum: .infinity))]
        } else {
            return [GridItem(.flexible(minimum: 1, maximum: .infinity), spacing: spacing),
                    GridItem(.flexible(minimum: 1, maximum: .infinity))]
        }
    }
}

