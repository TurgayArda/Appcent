//
//  FavoriteBuilder.swift
//  Appcent
//
//  Created by ArdaSisli on 26.03.2022.
//

import Foundation

final class FavoriteBuilder {
    static func make() -> FavoriteVC {
        let view = FavoriteVC()
        let interactor = FavoriteInteractor(service: GameDetailService())
        let presenter = FavoritePresenter(interactor: interactor, view: view)
        let router = FavoriteRouter(view: view)
        view.router = router
        view.presenter = presenter
        return view
    }
}
