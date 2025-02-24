//
//  APIEndpoints.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import Foundation

/// A struct to manage API base URLs and endpoints
/// Documentation:
///     https://developer.themoviedb.org/docs/getting-started
///
struct APIEndpoints {
    
    // MARK: - Base URLs
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w200"
    
    // MARK: - API Key
    // Ideally, the Secrets file should be included in the .gitignore to keep the KEYS secure.
    // However, for the purpose of this test, I am not adding it to the .gitignore file.
    static let apiKey = SecretsManager.apiKey
    static let accessToken = SecretsManager.accessToken

    // MARK: - Endpoints
    /// Returns the URL for fetching the most popular movies
    static func popularMoviesURL(page: Int = 1, language: APILanguage = .EN) -> URL? {
        if apiKey.isEmpty || accessToken.isEmpty {
            fatalError("keys not found")
        }
        return URL(string: "\(baseURL)/discover/movie?api_key=\(apiKey)&language=\(language.rawValue)&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)")
    }
    
    /// Returns the URL for fetching movie details
    static func movieDetailURL(movieID: Int, language: APILanguage = .EN) -> URL? {
        return URL(string: "\(baseURL)/movie/\(movieID)?language=\(language.rawValue)")
    }
    
    /// Returns the URL for searching movies
    static func searchMoviesURL(query: String, page: Int = 1, language: APILanguage = .EN) -> URL? {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "\(baseURL)/search/movie?query=\(encodedQuery)&include_adult=false&language=\(language.rawValue)&page=\(page)")
    }

    /// Returns the URL for fetching movie images
    static func imageURL(path: String) -> URL? {
        return URL(string: "\(imageBaseURL)\(path)")
    }
    
    /// Returns the URL for fetching now playing movies
//    static func nowPlayingMoviesURL(minDate: String, maxDate: String, page: Int = 1, language: APILanguage = .EN) -> URL? {
//        return URL(string: "\(baseURL)/discover/movie?language=\(language.rawValue)&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)&with_release_type=2|3&release_date.gte=\(minDate)&release_date.lte=\(maxDate)")
//    }
}
