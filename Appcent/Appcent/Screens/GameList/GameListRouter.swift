//
//  GameListRouter.swift
//  Appcent
//
//  Created by ArdaSisli on 23.03.2022.
//

import Foundation
import UIKit

class GameListRouter: GameListRouterProtocol {
    let view: UIViewController
    init( view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: GameListRouterOutPut) {
        switch route {
        case .detail(let ID):
            let gameDetail = GameDetailBuilder.make(ID: ID)
            view.show(gameDetail, sender: nil)
        }
    }
}
