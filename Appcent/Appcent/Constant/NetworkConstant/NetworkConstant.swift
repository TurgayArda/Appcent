//
//  NetworkConstant.swift
//  Appcent
//
//  Created by ArdaSisli on 28.03.2022.
//

import Foundation

final class NetworkConstant {
    enum GameListNetwork: String {
        case path_url = "https://api.rawg.io/api"
        case game_url = "/games?"
        case key = "key=83ad9191ef1f4ba88bdd11723444c5b3"
        
        static func gameListPath() -> String {
            return "\(path_url.rawValue)\(game_url.rawValue)\(key.rawValue)"
        }
    }
    
    enum GameDetailNetwork: String {
        case path_url = "https://api.rawg.io/api"
        case game_url = "/games/"
        case key = "?key=83ad9191ef1f4ba88bdd11723444c5b3"
        
        static func gameListPath(path: Int) -> String {
            return "\(path_url.rawValue)\(game_url.rawValue)\(path)\(key.rawValue)"
        }
    }
}
