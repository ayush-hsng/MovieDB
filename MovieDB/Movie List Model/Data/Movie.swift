//
//  Movie.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 19/10/23.
//

import Foundation

struct Movie: Codable, Identifiable {
    var id: Int
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var vote_average: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
        self.release_date = try container.decodeIfPresent(String.self, forKey: .release_date)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.vote_average = try container.decode(Double.self, forKey: .vote_average)
    }
    
    init() {
        self.id = -1
        self.overview = nil
        self.popularity = nil
        self.release_date = nil
        self.title = nil
        self.vote_average = nil
    }
}

struct Interval: Codable {
    var maximum: String
    var minimum: String
}

struct PopularMovieResult: Codable {
    var dates: Interval?
    var page: Int
    var results: [Movie]?
    var total_pages: Int
    var total_results: Int
}
