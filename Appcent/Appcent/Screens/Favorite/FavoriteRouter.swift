//
//  FavoriteRouter.swift
//  Appcent
//
//  Created by ArdaSisli on 26.03.2022.
//

import Foundation
import UIKit

class FavoriteRouter: FavoriteRouterProtocol {
    let view: UIViewController
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: FavoriteRouterOutPut) {
        switch route {
        case .detail(let id):
            let detailVC = GameDetailBuilder.make(ID: id)
            view.show(detailVC, sender: nil)
        }
    }
}
