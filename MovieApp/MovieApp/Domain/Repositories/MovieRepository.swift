//
//  MovieRepository.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

protocol MovieRepository {
    func fetchMovies(page: Int, language: APILanguage, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovieDetail(movieID: Int, language: APILanguage, completion: @escaping (Result<Movie, Error>) -> Void)
}
