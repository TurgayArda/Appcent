//
//  GameListPresenter.swift
//  Appcent
//
//  Created by ArdaSisli on 23.03.2022.
//

import Foundation

class GameListPresenter: GameListPresenterProtocol {
    var interactor: GameListInteractorProtocol?
    let view: GameListViewDelegate?
    
    init(interactor: GameListInteractorProtocol,
         view: GameListViewDelegate
    ){
        self.interactor = interactor
        self.view = view
        self.interactor?.delegate = self
    }
}

extension GameListPresenter {
    func load() {
        interactor?.load()
        view?.handleOutPut(.title(GameListConstant.GameListTitle.title.rawValue))
    }
}

extension GameListPresenter: GameListInteractorDelegate {
    func handleOutPut(_ output: GameListInteractorOutPut) {
        switch output {
        case .gameList(let game):
            view?.handleOutPut(.gameList(game))
        case .error(let error):
            view?.handleOutPut(.error(error))
        }
    }
}
