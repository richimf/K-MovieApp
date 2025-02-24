//
//  MovieListView.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import SwiftUI

struct MovieListView: View {

    @StateObject var viewModel: MovieListViewModel
    @StateObject var searchViewModel = DependencyContainer.shared.makeMovieSearchViewModel()

    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var didPerformRemoteSearch: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Search Bar
                if !isOfflineError {
                    HStack {
                        TextField("Search Movies...", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .onChange(of: searchText) { newValue in
                                handleSearchInput(newValue)
                            }

                        if isSearching {
                            Button("Cancel") {
                                cancelSearch()
                            }
                            .foregroundColor(.blue)
                            .padding(.trailing, 10)
                        }
                    }
                    .padding(.top, 10)
                }

                // MARK: - Movie List
                Group {
                    if viewModel.isLoading || searchViewModel.isLoading {
                        ProgressView("Loading Movies...")
                    } else if let error = viewModel.errorMessage ?? searchViewModel.errorMessage {
                        ErrorView(
                            iconName: error.contains("offline") ? "wifi.slash" : "exclamationmark.triangle",
                            message: error,
                            retryAction: {
                                if isSearching {
                                    searchViewModel.searchMovie(searchText)
                                } else {
                                    viewModel.fetchMovies()
                                }
                            }
                        )
                    } else if currentMovies.isEmpty {
                        // MARK: - No Movies Found View
                        VStack {
                            Spacer()
                            Image(systemName: "film")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.gray)
                                .padding(.bottom, 20)

                            Text("No Movies Found")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .bold()
                            Spacer()
                        }
                    } else {
                        List(currentMovies.indices, id: \.self) { index in
                            let movie = currentMovies[index]
                            NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                MovieRowView(movie: movie)
                            }
                            .onAppear {
                                if index == currentMovies.count - 1 {
                                    loadMoreMoviesIfNeeded()
                                }
                            }
                        }
                        .listStyle(PlainListStyle())

                        if viewModel.isPaginating {
                            ProgressView("Loading more movies...")
                                .padding()
                        }
                    }
                }
            }
            .navigationTitle("Movies")
            .onAppear {
                viewModel.fetchMovies()
            }
        }
    }

    // MARK: - Current Movies (Local or Remote)
    private var currentMovies: [Movie] {
        if isSearching {
            if !localFilteredMovies.isEmpty {
                return localFilteredMovies
            } else if didPerformRemoteSearch {
                return searchViewModel.movies
            } else {
                return []
            }
        } else {
            return viewModel.movies
        }
    }

    // MARK: - Local Filtered Movies
    private var localFilteredMovies: [Movie] {
        viewModel.movies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    // MARK: - Handle Search Input
    private func handleSearchInput(_ input: String) {
        isSearching = !input.isEmpty

        if isSearching {
            if localFilteredMovies.isEmpty && !didPerformRemoteSearch {
                searchViewModel.searchMovie(input)
                didPerformRemoteSearch = true
            }
        } else {
            cancelSearch()
        }
    }

    // MARK: - Cancel Search
    private func cancelSearch() {
        searchText = ""
        isSearching = false
        didPerformRemoteSearch = false
        searchViewModel.movies = []
    }

    // MARK: - Pagination Trigger
    private func loadMoreMoviesIfNeeded() {
        if !isSearching {
            viewModel.loadMoreMovies()
        } else if didPerformRemoteSearch {
            searchViewModel.loadMoreSearchResults(query: searchText)
        }
    }

    // MARK: - Check for Offline Error
    private var isOfflineError: Bool {
        let errorMessage = viewModel.errorMessage ?? searchViewModel.errorMessage ?? ""
        return errorMessage.lowercased().contains("offline") || errorMessage.lowercased().contains("no internet")
    }
}
