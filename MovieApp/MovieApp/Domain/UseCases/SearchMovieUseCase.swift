//
//  SearchMovieUseCase.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import Foundation

class SearchMovieUseCase {
    
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func searchMovie(query: String, page: Int, language: APILanguage, completion: @escaping (Result<[Movie], Error>) -> Void) {
        repository.searchMovie(query: query, page: page, language: language, completion: completion)
    }
}
