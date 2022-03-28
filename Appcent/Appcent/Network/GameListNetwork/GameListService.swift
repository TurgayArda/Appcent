//
//  GameListService.swift
//  Appcent
//
//  Created by ArdaSisli on 23.03.2022.
//

import Foundation
import Alamofire

protocol GameListServiceProtocol {
    func fetchAllData(
         onSuccess: @escaping ([GameResult]) -> Void,
         onError: @escaping (String) -> Void
         )
}

class GameListService: GameListServiceProtocol {
    func fetchAllData(onSuccess: @escaping ([GameResult]) -> Void, onError: @escaping (String) -> Void) {
        AF.request(NetworkConstant.GameListNetwork.gameListPath(), method: .get).responseDecodable(of: Result.self) {
            game in
            guard let data = game.value else {
                return onError("Hata")
            }
            let dataTwo = data.results
            onSuccess(dataTwo)
        }
    }
}
