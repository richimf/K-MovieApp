//
//  FetchMoviesUseCase.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

/// The business logic for fetching movies, which uses the repository.
class FetchMoviesUseCase {

    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(page: Int, language: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        repository.fetchMovies(page: page, language: language, completion: completion)
    }
}
