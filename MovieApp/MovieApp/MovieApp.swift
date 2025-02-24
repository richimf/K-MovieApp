//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import SwiftUI

@main
struct MovieApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = DependencyContainer.shared.makeMovieListViewModel()
            MovieListView(viewModel: viewModel)
        }
    }
}
