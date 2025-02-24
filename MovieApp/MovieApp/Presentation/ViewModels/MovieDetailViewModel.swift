//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import SwiftUI

class MovieDetailViewModel: ObservableObject {

    private let fetchMovieDetailUseCase: FetchMovieDetailUseCase

    init(fetchMovieDetailUseCase: FetchMovieDetailUseCase) {
        self.fetchMovieDetailUseCase = fetchMovieDetailUseCase
        fetchMovieDetail()
    }

    func fetchMovieDetail() {
       
    }
}
