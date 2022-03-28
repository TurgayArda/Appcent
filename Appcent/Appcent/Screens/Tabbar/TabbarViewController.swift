//
//  TabbarViewController.swift
//  Appcent
//
//  Created by ArdaSisli on 23.03.2022.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = .lightGray
        navigationItem.hidesBackButton = true
        let VC1 = UINavigationController(rootViewController: GameListBuilder.make())
        let VC2 = UINavigationController(rootViewController: FavoriteBuilder.make())
        self.setViewControllers([VC1, VC2], animated: true)
        guard let item = self.tabBar.items else { return }
        item[0].image = UIImage(systemName: "house.fill")
        item[1].image = UIImage(systemName: "heart.fill")
    }
}
