//
//  MovieRowView.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//
import SwiftUI

struct MovieRowView: View {
    let movie: Movie

    var body: some View {
        HStack {
            if let posterPath = movie.posterPath,
               let url = URL(string: "\(APIEndpoints.imageBaseURL)\(posterPath)") {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 50, height: 75)
                .cornerRadius(5)
            } else {
                // Placeholder if image is missing
                Color.gray
                    .frame(width: 50, height: 75)
                    .cornerRadius(5)
            }

            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.releaseDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
