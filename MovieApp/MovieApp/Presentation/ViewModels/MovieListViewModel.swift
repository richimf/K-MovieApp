//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import SwiftUI

class MovieListViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var isPaginating: Bool = false
    @Published var errorMessage: String?

    private let fetchMoviesUseCase: FetchMoviesUseCase
    private var currentPage: Int = 1
    private var canLoadMore: Bool = true

    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
        fetchMovies()
    }

    // MARK: - Fetch Initial Movies
    func fetchMovies() {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        fetchMoviesUseCase.execute(page: currentPage, language: .EN) { [weak self] result in
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

    // MARK: - Load More for Pagination
    func loadMoreMovies() {
        guard !isPaginating && canLoadMore else { return }

        isPaginating = true
        currentPage += 1

        fetchMoviesUseCase.execute(page: currentPage, language: .EN) { [weak self] result in
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
