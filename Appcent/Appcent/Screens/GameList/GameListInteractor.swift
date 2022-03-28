//
//  GameListInteractor.swift
//  Appcent
//
//  Created by ArdaSisli on 23.03.2022.
//

import Foundation

class GameListInteractor: GameListInteractorProtocol {
    var delegate: GameListInteractorDelegate?
    let service: GameListServiceProtocol?
    
    init(service: GameListServiceProtocol) {
        self.service = service
    }
}

extension GameListInteractor {
    func load() {
        service?.fetchAllData(onSuccess: { [delegate] game in
            delegate?.handleOutPut(.gameList(game))
        }, onError: { [delegate] error in
            delegate?.handleOutPut(.error(error))
        })
    }
}
