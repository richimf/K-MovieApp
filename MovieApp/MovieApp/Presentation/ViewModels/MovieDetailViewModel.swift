//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import SwiftUI

class MovieDetailViewModel: ObservableObject {

    @Published var movie: Movie?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let fetchMovieDetailUseCase: FetchMovieDetailUseCase

    init(fetchMovieDetailUseCase: FetchMovieDetailUseCase) {
        self.fetchMovieDetailUseCase = fetchMovieDetailUseCase
    }

    func fetchMovieDetail(movieID: Int, language: APILanguage = LanguageUtility.getDeviceAPILanguage()) {
        isLoading = true
        errorMessage = nil

        fetchMovieDetailUseCase.fetchMovieDetail(movieID: movieID, language: language) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movie):
                    self?.movie = movie
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
