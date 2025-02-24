//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

struct MovieListResponse: Codable {
    let page: Int
    let results: [MovieDTO]
    let total_pages: Int
    let total_results: Int
}
