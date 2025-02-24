//
//  MovieSearchViewModel.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import SwiftUI

class MovieSearchViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let searchMovieUseCase: SearchMovieUseCase

    init(searchMovieUseCase: SearchMovieUseCase) {
        self.searchMovieUseCase = searchMovieUseCase
    }

    func searchMovie(_ query: String) {
        isLoading = true
        errorMessage = nil
        
        searchMovieUseCase.searchMovie(query: query, language: .EN) { [weak self] result in
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
