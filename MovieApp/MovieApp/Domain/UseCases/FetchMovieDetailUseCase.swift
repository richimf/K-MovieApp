//
//  FetchMovieDetailUseCase.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

class FetchMovieDetailUseCase {
    
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func fetchMovieDetail(movieID: Int, language: APILanguage, completion: @escaping (Result<Movie, Error>) -> Void) {
        repository.fetchMovieDetail(movieID: movieID, language: language, completion: completion)
    }
}
