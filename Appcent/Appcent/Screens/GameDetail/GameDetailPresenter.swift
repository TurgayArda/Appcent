//
//  GameDetailPresenter.swift
//  Appcent
//
//  Created by ArdaSisli on 25.03.2022.
//

import Foundation

class GameDetailPresenter: GameDetailPresenterProtocol {
    var interactor: GameDetailInteractorProtocol?
    var view: GameDetailViewDelegate?
    
    init(interactor: GameDetailInteractorProtocol,
         view: GameDetailViewDelegate
    ){
        self.interactor = interactor
        self.view = view
        self.interactor?.delegate = self
    }
}

extension GameDetailPresenter {
    func load() {
        interactor?.load()
    }
}

extension GameDetailPresenter: GameDetailInteractorDelegate {
    func handleOutPut(_ output: GameDetailInteractorOutPut) {
        switch output {
        case .gameDetailList(let game):
            view?.handleOutPut(.gameDetailList(game))
        case .gameDetailError(let error):
            view?.handleOutPut(.gameDetailError(error))
        }
    }
}
