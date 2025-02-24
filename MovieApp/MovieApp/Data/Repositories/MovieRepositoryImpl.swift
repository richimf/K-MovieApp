//
//  MovieRepositoryImpl.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

/// Implements the MovieRepository protocol and uses MovieAPIService to get data.
class MovieRepositoryImpl: MovieRepository {

    private let apiService: MovieAPIService

    init(apiService: MovieAPIService) {
        self.apiService = apiService
    }

    func fetchMovies(page: Int, language: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
    }
    
    func fetchMovieDetail(movieID: Int, language: String, completion: @escaping (Result<Movie, any Error>) -> Void) {
        
    }

}
