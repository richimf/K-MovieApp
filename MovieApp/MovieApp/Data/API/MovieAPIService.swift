//
//  MovieAPIService.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import Foundation

/// Responsible for fetching movie data from TheMovieDB API.
class MovieAPIService {

}

struct MovieListResponse: Codable {
    let results: [MovieDTO]
}
