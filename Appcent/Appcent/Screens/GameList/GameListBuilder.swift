//
//  GameListBuilder.swift
//  Appcent
//
//  Created by ArdaSisli on 23.03.2022.
//

import Foundation

final class GameListBuilder {
    static func make() -> GameListVC {
        let view = GameListVC()
        let interactor = GameListInteractor(service: GameListService())
        let presenter = GameListPresenter(interactor: interactor, view: view)
        let router = GameListRouter(view: view)
        view.router = router
        view.presenter = presenter
        return view
    }
}
