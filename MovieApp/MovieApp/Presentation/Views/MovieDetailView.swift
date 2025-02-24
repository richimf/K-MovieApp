//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//
import SwiftUI

struct MovieDetailView: View {

    @StateObject private var viewModel: MovieDetailViewModel

    let movieID: Int

    // Initialize using DependencyContainer
    init(movieID: Int) {
        self.movieID = movieID
        let viewModel = DependencyContainer.shared.makeMovieDetailViewModel(movieID: movieID)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .onAppear {
                viewModel.fetchMovieDetail(movieID: movieID)
            }
            .navigationTitle(viewModel.movie?.title ?? "Loading...")
            .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading Movie Details...")
                .progressViewStyle(CircularProgressViewStyle())
        } else if let errorMessage = viewModel.errorMessage {
            Text("Error: \(errorMessage)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        } else if let movie = viewModel.movie {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let posterPath = movie.posterPath,
                       let url = URL(string: "\(APIEndpoints.imageBaseURL)\(posterPath)") {
                        AsyncImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                    }

                    Text(movie.title)
                        .font(.largeTitle)
                        .bold()

                    Text("Release Date: \(movie.releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(overviewText(for: movie.overview))
                            .font(.body)
                            .padding(.top, 8)

                    Spacer()
                }
                .padding()
            }
        } else {
            Text("No Movie Data")
                .foregroundColor(.gray)
        }
    }
    
    private func overviewText(for overview: String?) -> String {
        guard let overview = overview, !overview.isEmpty else {
            return "No overview available."
        }
        return "\(overview)"
    }
}
