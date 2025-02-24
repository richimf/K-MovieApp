//
//  Movie.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

struct Movie: Identifiable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let releaseDate: String
    let language: String
}
