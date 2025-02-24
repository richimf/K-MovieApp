//
//  DependencyContainer.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

/// This file create a manual dependency injection that helps to initialize the app.

import Foundation

final class DependencyContainer {

    static let shared = DependencyContainer()

    // Services
    let apiService: MovieAPIService
    let repository: MovieRepository
    let fetchMoviesUseCase: FetchMoviesUseCase

    private init() {
        self.apiService = MovieAPIService()
        self.repository = MovieRepositoryImpl(apiService: apiService)
        self.fetchMoviesUseCase = FetchMoviesUseCase(repository: repository)
    }

    func makeMovieListViewModel() -> MovieListViewModel {
        return MovieListViewModel(fetchMoviesUseCase: fetchMoviesUseCase)
    }

    func makeMovieDetailViewModel(movieID: Int) -> MovieDetailViewModel {
        let fetchMovieDetailUseCase = FetchMovieDetailUseCase(repository: repository)
        return MovieDetailViewModel(fetchMovieDetailUseCase: fetchMovieDetailUseCase)
    }
    
    func makeMovieSearchViewModel() -> MovieSearchViewModel {
        let fetchMovieSearchUseCase = SearchMovieUseCase(repository: repository)
        return MovieSearchViewModel(searchMovieUseCase: fetchMovieSearchUseCase)
    }
}
