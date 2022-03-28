//
//  GameDetailModel.swift
//  Appcent
//
//  Created by ArdaSisli on 25.03.2022.
//

import Foundation

// MARK: - GameResult
struct GameDetailResult: Codable {
    let id: Int
    let name: String
    let metacritic: Int
    let metacriticPlatforms: [MetacriticPlatform]
    let released: String
    let backgroundImage: String
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case metacritic
        case metacriticPlatforms = "metacritic_platforms"
        case released
        case backgroundImage = "background_image"
        case descriptionRaw = "description_raw"
    }
}

// MARK: - MetacriticPlatform
struct MetacriticPlatform: Codable {
    let metascore: Int
    let url: String
    let platform: MetacriticPlatformPlatform
}

// MARK: - MetacriticPlatformPlatform
struct MetacriticPlatformPlatform: Codable {
    let platform: Int
    let name, slug: String
}

//typealias DetailResult = [GameDetailResult]
