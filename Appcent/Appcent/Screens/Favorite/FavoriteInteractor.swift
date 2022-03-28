//
//  FavoriteInteractor.swift
//  Appcent
//
//  Created by ArdaSisli on 26.03.2022.
//

import Foundation

class FavoriteInteractor {
    var service: GameDetailServiceProtocol?
    var delegate: FavoriteInteractorDelegate?
    
    init(service:GameDetailServiceProtocol){
        self.service = service
    }
}

extension FavoriteInteractor: FavoriteInteractorProtocol {
    func load(path: Int) {
        service?.fetchAllData(path: path, onSuccess: { [delegate] game in
            delegate?.handleOutPut(.gameDetailList(game))
        }, onError: { [delegate] error in
            delegate?.handleOutPut(.gameDetailError(error))
        })
    }
}
