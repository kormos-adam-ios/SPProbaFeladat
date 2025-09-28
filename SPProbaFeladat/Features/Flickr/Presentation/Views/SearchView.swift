//
//  SearchView.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVStack(spacing: 10) {
                    if viewModel.filteredHistory.isEmpty {
                        Text(viewModel.searchText)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                Task {
                                    let ok = await viewModel.search(viewModel.searchText)
                                    if ok { dismiss() }
                                }
                            }
                    }
                    else {
                        ForEach(viewModel.filteredHistory.indices, id: \.self) { index in
                            Text(viewModel.filteredHistory[index])
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    Task {
                                        let ok = await viewModel.search(viewModel.filteredHistory[index])
                                        if ok { dismiss() }
                                    }
                                }
                        }
                    }
                }
                .listSectionSeparator(.hidden)
                .padding(.bottom, 70)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16, weight: .semibold))
                    .opacity(0.8)
                
                TextField("Search", text: $viewModel.searchText)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($isSearchFocused)
                    .submitLabel(.search)
                    .onSubmit {
                        Task {
                            let ok = await viewModel.search(viewModel.searchText)
                            if ok { dismiss() }
                        }
                    }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(.white.opacity(0.35), lineWidth: 1)
            )
            .shadow(radius: 20, x: 0, y: 8)
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
        .navigationTitle(!viewModel.filteredHistory.isEmpty ? "Search history" : "New search")
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isSearchFocused = true
            }
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil), actions: {
            Button("OK") {
                viewModel.errorMessage = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isSearchFocused = true
                }
            }
        }, message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        })
    }
}
