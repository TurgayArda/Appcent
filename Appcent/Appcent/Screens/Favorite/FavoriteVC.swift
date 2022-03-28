//
//  FavoriteVC.swift
//  Appcent
//
//  Created by ArdaSisli on 23.03.2022.
//

import UIKit

class FavoriteVC: UIViewController {

    private  var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         collectionView.backgroundColor = .white
         return collectionView
     }()
    
    var router: FavoriteRouterProtocol?
    var provider = FavoriteProvider()
    var presenter: FavoritePresenterProtocol?
    let error = String()
    var gameData: GameDetailResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserDefault()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.hidesBottomBarWhenPushed = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.hidesBottomBarWhenPushed = true
    }
    
    private func getUserDefault() {
        let userID = UserDefaults.standard
        let arrayID = userID.object(forKey: UserDefaultConstant.forKey.rawValue) as? [Int] ?? [Int]()
        provider.dataTwo.removeAll()
        for i in 0..<arrayID.count {
            presenter?.load(path: arrayID[i])
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func initDelegate() {
        collectionView.register(
            FavoriteCollectionViewCell.self,
        forCellWithReuseIdentifier: FavoriteCollectionViewCell.Identifier.path.rawValue
    )
        provider.delegate = self
        collectionView.delegate = provider
        collectionView.dataSource = provider
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        makeCollection()
    }
}

extension FavoriteVC: FavoriteViewDelegate {
    func handleOutPut(_ output: FavoritePresenterOutPut) {
        switch output {
        case .gameDetailList(let game):
            provider.load(value: game)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .gameDetailError(let string):
            print(string)
        case .gameDetailTitle(let title):
            self.navigationItem.title = title
        }
    }
}

extension FavoriteVC: FavoriteProviderDelegate {
    func selected(at select: Int) {
        router?.navigate(to: .detail(select))
    }
}

extension FavoriteVC {
    func makeCollection() {
        collectionView.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
                .offset(0)
            make
                .left
                .equalTo(view)
                .offset(0)
            make
                .right
                .equalTo(view)
                .offset(0)
            make
                .bottom
                .equalTo(view.safeAreaLayoutGuide)
                .offset(0)
        }
    }
}
