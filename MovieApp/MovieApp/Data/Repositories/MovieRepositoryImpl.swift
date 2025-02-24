//
//  MovieRepositoryImpl.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//
import Foundation

/// Implements the MovieRepository protocol and uses MovieAPIService to get data.

class MovieRepositoryImpl: MovieRepository {

    private let apiService: MovieAPIService

    init(apiService: MovieAPIService) {
        self.apiService = apiService
    }

    // MARK: - Fetch Movies
    func fetchMovies(page: Int, language: APILanguage, completion: @escaping (Result<[Movie], Error>) -> Void) {
        apiService.fetchPopularMovies(page: page, language: language) { result in
            switch result {
            case .success(let movieDTOs):
                // Map MovieDTO to Movie
                let movies = movieDTOs.map { $0.toMovie() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Fetch Movie Detail
    func fetchMovieDetail(movieID: Int, language: APILanguage, completion: @escaping (Result<Movie, Error>) -> Void) {
        apiService.fetchMovieDetails(movieID: movieID, language: language) { result in
            switch result {
            case .success(let movieDTO):
                // Map MovieDTO to Movie
                let movie = movieDTO.toMovie()
                completion(.success(movie))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
