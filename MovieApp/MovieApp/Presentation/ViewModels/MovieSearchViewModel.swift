//
//  MovieSearchViewModel.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import SwiftUI

class MovieSearchViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var isPaginating: Bool = false
    @Published var errorMessage: String?

    private let searchMovieUseCase: SearchMovieUseCase
    private var currentPage: Int = 1
    private var canLoadMore: Bool = true
    private var currentQuery: String = ""

    init(searchMovieUseCase: SearchMovieUseCase) {
        self.searchMovieUseCase = searchMovieUseCase
    }

    // MARK: - Search Movie
    func searchMovie(_ query: String) {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil
        currentPage = 1
        currentQuery = query

        searchMovieUseCase.searchMovie(query: query, page: currentPage, language: .EN) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.canLoadMore = !movies.isEmpty
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - Load More Search Results
    func loadMoreSearchResults(query: String) {
        guard !isPaginating && canLoadMore && query == currentQuery else { return }

        isPaginating = true
        currentPage += 1

        searchMovieUseCase.searchMovie(query: query, page: currentPage, language: .EN) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isPaginating = false
                switch result {
                case .success(let movies):
                    self.movies.append(contentsOf: movies)
                    self.canLoadMore = !movies.isEmpty
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
