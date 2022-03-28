//
//  GameDetailInteractor.swift
//  Appcent
//
//  Created by ArdaSisli on 25.03.2022.
//

import Foundation

class GameDetailInteractor {
    var id: Int?
    var service: GameDetailServiceProtocol?
    var delegate: GameDetailInteractorDelegate?
    
    init(id: Int,
         service:GameDetailServiceProtocol
    ){
        self.id = id
        self.service = service
    }
}

extension GameDetailInteractor: GameDetailInteractorProtocol {
    func load() {
        guard let gameID = id else { return }
        service?.fetchAllData(path: gameID, onSuccess: { [delegate] game in
            delegate?.handleOutPut(.gameDetailList(game))
        }, onError: { [delegate] error in
            delegate?.handleOutPut(.gameDetailError(error))
        })
    }
}
