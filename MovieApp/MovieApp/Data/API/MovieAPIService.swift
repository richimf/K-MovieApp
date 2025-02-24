//
//  MovieAPIService.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import Foundation

/// Responsible for fetching movie data from TheMovieDB API.
final class MovieAPIService {
    
    // MARK: - Generic Request Handler
    private func fetchMovies<T: Decodable>(url: URL?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }

        APIManager.shared.performRequest(url: url, completion: completion)
    }

    // MARK: - Fetch Popular Movies
    func fetchPopularMovies(page: Int = 1, language: APILanguage = .EN, completion: @escaping (Result<[MovieDTO], Error>) -> Void) {
        let url = APIEndpoints.popularMoviesURL(page: page, language: language)
        fetchMovies(url: url) { (result: Result<MovieListResponse, Error>) in
            self.handleMovieListResponse(result, completion: completion)
        }
    }
    
    // MARK: - Fetch Movie Details
    func fetchMovieDetails(movieID: Int, language: APILanguage = .EN, completion: @escaping (Result<MovieDetailDTO, Error>) -> Void) {
        let url = APIEndpoints.movieDetailURL(movieID: movieID, language: language)
        fetchMovies(url: url, completion: completion)
    }

    // MARK: - Search Movies
    func searchMovies(query: String, page: Int = 1, language: APILanguage = .EN, completion: @escaping (Result<[MovieDTO], Error>) -> Void) {
        let url = APIEndpoints.searchMoviesURL(query: query, page: page, language: language)
        fetchMovies(url: url) { (result: Result<MovieListResponse, Error>) in
            self.handleMovieListResponse(result, completion: completion)
        }
    }
    
    // MARK: - Helper Method to Handle MovieListResponse
    private func handleMovieListResponse(_ result: Result<MovieListResponse, Error>, completion: @escaping (Result<[MovieDTO], Error>) -> Void) {
        switch result {
        case .success(let response):
            completion(.success(response.results))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
