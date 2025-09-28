//
//  PhotoDetailView.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//


import SwiftUI
import Kingfisher

struct PhotoDetailView: View {
    @StateObject var viewModel: PhotoDetailViewModel
    @State var presentFullScreen: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                imageView
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.large)
                }
                else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .padding()
                } else {
                    detailsView(info: viewModel.info)
                }
            }
            .padding()
        }
        .refreshable {
            viewModel.load()
        }
        .fullScreenCover(isPresented: hasDownloadedImage) {
            if let downloadedImage = viewModel.downloadedImage {
                FullScreenGalleryView(data: [downloadedImage], show: hasDownloadedImage)
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
    
    @ViewBuilder
    var imageView: some View {
        KFImage(viewModel.info.mediumURL)
            .resizable()
            .placeholder {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .aspectRatio(contentMode: .fit)
            }
            .roundCorner(radius: Radius.point(10))
            .scaledToFit()
            .onTapGesture {
                viewModel.imageTapped()
            }
    }
    
    @ViewBuilder
    private func detailsView(info: FlickrPhotoInfo) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                if let title = info.title, !title.isEmpty {
                    PhotoDetailRow(title: "Title", value: title)
                }
                
                if let description = info.description, !description.isEmpty {
                    PhotoDetailRow(title: "Description", value: description)
                }
                
                if let ownerName = info.ownerName, let ownerUsername = info.ownerUsername {
                    let realNameAndOwner = "\(ownerName) @\(ownerUsername)"
                    PhotoDetailRow(title: "Owner", value: realNameAndOwner)
                }
                
                if let dateString = info.dateString {
                    PhotoDetailRow(title: "Taken", value: dateString)
                }
                
                PhotoDetailRow(title: "Views", value: info.formattedViews)
                
                if let tags = info.tags, !tags.isEmpty {
                    PhotoDetailRow(title: "Tags", value: tags.joined(separator: ", "))
                }
            }
            
            Spacer()
        }
    }
    
    var hasDownloadedImage: Binding<Bool> {
        Binding(
            get: { viewModel.downloadedImage != nil },
            set: { newValue in
                if !newValue {
                    viewModel.downloadedImage = nil
                }
            }
        )
    }
}
