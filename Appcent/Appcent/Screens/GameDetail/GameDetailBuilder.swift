//
//  GameDetailBuilder.swift
//  Appcent
//
//  Created by ArdaSisli on 25.03.2022.
//

import Foundation

class GameDetailBuilder {
    static func make(ID: Int) -> GameDetailVC {
        let view = GameDetailVC()
        let interactor = GameDetailInteractor(id: ID, service: GameDetailService())
        let presenter = GameDetailPresenter(interactor: interactor, view: view)
        view.presenter = presenter
        return view
    }
}
