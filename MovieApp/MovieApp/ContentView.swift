//
//  ContentView.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = DependencyContainer.shared.makeMovieListViewModel()

    var body: some View {
        MovieListView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
