//
//  MovieDTO.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

struct MovieDTO: Codable {
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

/// Maps `MovieDTO` to simplified `Movie` model
extension MovieDTO {
    func toMovie() -> Movie {
        return Movie(
            id: self.id,
            title: self.title,
            overview: self.overview,
            posterPath: self.posterPath,
            releaseDate: self.releaseDate,
            language: self.originalLanguage
        )
    }
}
