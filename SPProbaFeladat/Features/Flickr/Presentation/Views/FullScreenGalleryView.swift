//
//  FullScreenGalleryView.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

import SwiftUI
import LazyPager

struct FullScreenGalleryView: View {
    
    var direction: Direction = .horizontal
    
    var data: [ImageWithURL]
    
    @Binding var show: Bool
    @State var opacity: CGFloat = 1
    @State var index = 0
    @State var loadPager = false
    
    @State private var closeButtonVisible: Bool = true
    
    var body: some View {
        VStack {
            LazyPager(data: data, page: $index, direction: direction) { element in
                ZStack {
                    element.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .zoomable(min: 1, max: 5)
            .onZoom({ url, zoomLevel in
                setCloseButtonVisible(zoomLevel == 1)
            })
            .onDismiss(backgroundOpacity: $opacity) {
                setCloseButtonVisible(false)
                show = false
            }
            .onTap {
                setCloseButtonVisible(!closeButtonVisible)
            }
            .onDrag {
                setCloseButtonVisible(false)
            }
            .pageSpacing(10)
            .background(.black.opacity(opacity))
            .background(ClearFullScreenBackground())
            .ignoresSafeArea()
            .overlay(alignment: .topTrailing) {
                if closeButtonVisible {
                    Button {
                        show = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .shadow(radius: 1)
                            .padding()
                    }
                }
            }
        }
    }
    
    private func setCloseButtonVisible(_ visible: Bool) {
        withAnimation(.easeInOut(duration: 0.3)) {
            closeButtonVisible = visible
        }
    }
}

