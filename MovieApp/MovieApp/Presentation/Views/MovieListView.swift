//
//  MovieListView.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//
import SwiftUI

struct MovieListView: View {

    @StateObject var viewModel: MovieListViewModel

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Popular Movies")
                .onAppear {
                    viewModel.fetchMovies()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading Movies...")
                .progressViewStyle(CircularProgressViewStyle())
        } else if let errorMessage = viewModel.errorMessage {
            Text("Error: \(errorMessage)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        } else {
            List(viewModel.movies) { movie in
                
                NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                    MovieRowView(movie: movie)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}
