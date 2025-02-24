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
    @Published var errorMessage: String?

    private let fetchMoviesUseCase: FetchMoviesUseCase

    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
        fetchMovies()
    }

    func fetchMovies() {
        isLoading = true
        errorMessage = nil

        fetchMoviesUseCase.execute(page: 1, language: .EN) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
