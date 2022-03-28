//
//  GameDetailService.swift
//  Appcent
//
//  Created by ArdaSisli on 25.03.2022.
//

import Foundation
import Alamofire

protocol GameDetailServiceProtocol {
    func fetchAllData(
         path: Int,
         onSuccess: @escaping (GameDetailResult) -> Void,
         onError: @escaping (String) -> Void
         )
}

class GameDetailService: GameDetailServiceProtocol {
    func fetchAllData(path: Int, onSuccess: @escaping (GameDetailResult) -> Void, onError: @escaping (String) -> Void) {
        AF.request(NetworkConstant.GameDetailNetwork.gameListPath(path: path), method: .get).responseDecodable(of: GameDetailResult.self) {
            game in
            guard let data = game.value else {
                return onError("Hata")
            }
            onSuccess(data)
        }
    }
}
