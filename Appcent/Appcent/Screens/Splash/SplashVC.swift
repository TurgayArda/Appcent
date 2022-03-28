//
//  SplashVC.swift
//  Appcent
//
//  Created by ArdaSisli on 28.03.2022.
//

import UIKit
import Alamofire
import SnapKit

class Connect {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class SplashVC: UIViewController {
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Appcent")
        image.alpha = 0.9
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        animation()
    }
    
    func animation() {
        UIView.animate(withDuration: 2, animations: {
            self.logoImage.alpha = 1
        }, completion: { _ in
            self.isNetwork()
        })
    }
    
    func isNetwork() {
        if Connect.isConnected() {
            let viewController = TabbarViewController()
            viewController.modalPresentationStyle = .fullScreen
            self.show(viewController, sender: nil)
        }else{
            let errorAlert = UIAlertController(title: SplashConstant.SplashNetwork.alertTitle.rawValue,
                message: SplashConstant.SplashNetwork.alertMessage.rawValue,
                preferredStyle: .alert
        )
            let errorAction = UIAlertAction(title: SplashConstant.SplashNetwork.actionTitle.rawValue,
                style: .cancel
        )
            errorAlert.addAction(errorAction)
             self.present(errorAlert, animated: true)
        }
    }
    
    func configure() {
        view.backgroundColor = .white
        view.addSubview(logoImage)
        makeLogo()
    }
}

extension SplashVC {
    func makeLogo() {
        logoImage.snp.makeConstraints { make in
            make
                .centerX
                .equalTo(view.snp.centerX)
            make
                .top
                .equalTo(view.frame.height / 2.5)
            make
                .height
                .equalTo(100)
        }
    }
}
