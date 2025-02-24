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

    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Search Bar
                HStack {
                    TextField("Search Movies...", text: $searchText, onCommit: {
                        performSearch()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                    if isSearching {
                        Button("Cancel") {
                            cancelSearch()
                        }
                        .foregroundColor(.blue)
                        .padding(.trailing, 10)
                    }
                }
                .padding(.top, 10)

                // MARK: - Content
                Group {
                    if isSearching {
                        searchResultsView
                    } else {
                        movieListView
                    }
                }
            }
            .navigationTitle(isSearching ? "Search Results" : "Popular Movies")
            .onAppear {
                viewModel.fetchMovies()
            }
        }
    }

    // MARK: - Movie List View (Popular Movies)
    private var movieListView: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading Movies...")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)").foregroundColor(.red)
            } else {
                List(viewModel.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                        MovieRowView(movie: movie)
                    }
                }
            }
        }
    }

    // MARK: - Search Results View
    private var searchResultsView: some View {
        Group {
            if searchViewModel.isLoading {
                ProgressView("Searching Movies...")
            } else if let error = searchViewModel.errorMessage {
                Text("Error: \(error)").foregroundColor(.red)
            } else if searchViewModel.movies.isEmpty {
                Text("No results found").foregroundColor(.gray)
            } else {
                List(searchViewModel.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                        MovieRowView(movie: movie)
                    }
                }
            }
        }
    }

    // MARK: - Functions

    private func performSearch() {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        isSearching = true
        searchViewModel.searchMovie(searchText)
    }

    private func cancelSearch() {
        searchText = ""
        isSearching = false
        searchViewModel.movies = []
    }
}
