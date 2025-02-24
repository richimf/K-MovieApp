//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import SwiftUI

class MovieListViewModel: ObservableObject {
 
    private let fetchMoviesUseCase: FetchMoviesUseCase

    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
        fetchMovies()
    }

    func fetchMovies() {

    }
}
