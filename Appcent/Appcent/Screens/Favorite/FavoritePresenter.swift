//
//  FavoritePresenter.swift
//  Appcent
//
//  Created by ArdaSisli on 26.03.2022.
//

import Foundation

class FavoritePresenter: FavoritePresenterProtocol {
    var interactor: FavoriteInteractorProtocol?
    var view: FavoriteViewDelegate?
    init(interactor: FavoriteInteractorProtocol,
         view: FavoriteViewDelegate
    ){
        self.interactor = interactor
        self.view = view
        self.interactor?.delegate = self
    }
}

extension FavoritePresenter {
    func load(path: Int) {
        interactor?.load(path: path)
        view?.handleOutPut(.gameDetailTitle(FavoriConstant.title.rawValue))
    }
}

extension FavoritePresenter: FavoriteInteractorDelegate {
    func handleOutPut(_ output: FavoriteInteractorOutPut) {
        switch output {
        case .gameDetailList(let game):
            view?.handleOutPut(.gameDetailList(game))
        case .gameDetailError(let error):
            view?.handleOutPut(.gameDetailError(error))
        }
    }
}
