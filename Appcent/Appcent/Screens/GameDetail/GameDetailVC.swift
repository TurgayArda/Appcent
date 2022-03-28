//
//  GameDetailVC.swift
//  Appcent
//
//  Created by ArdaSisli on 25.03.2022.
//

import UIKit
import SnapKit
import AlamofireImage

class GameDetailVC: UIViewController {
    
    private var gameImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 48), forImageIn: .normal)
        return button
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private var releaseLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private var metacriticLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        scroll.isPagingEnabled = true
        scroll.bounces = true
        scroll.contentMode = .scaleAspectFit
        scroll.backgroundColor = .white
        scroll.contentSize = CGSize(width: 0 , height: view.frame.height)
        return scroll
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    var presenter: GameDetailPresenterProtocol?
    var errorMessage = String()
    var isFavorite = Bool()
    var gameID: Int?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        presenter?.load()
        configure()
        view.backgroundColor = .white
    }
    
   private func configure() {
        view.addSubview(gameImage)
        view.addSubview(favoriteButton)
        view.addSubview(nameLabel)
        view.addSubview(releaseLabel)
        view.addSubview(metacriticLabel)
        view.addSubview(scrollView)
        makeImage()
        makeFavorite()
        makeName()
        makeRelease()
        makeMeta()
        makeScroll()
        favorite()
    }
    
    private func favorite() {
        if isFavorite {
            image = UIImage(systemName: "hand.thumbsdown.fill")
            favoriteButton.tintColor = .red
        }else{
            image = UIImage(systemName: "hand.thumbsup.fill")
            favoriteButton.tintColor = .green
        }
        guard let buttonImage = image else {  return }
        favoriteButton.setImage(buttonImage, for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteList(_:)), for: .touchUpInside)
    }
    
    @objc func favoriteList(_ favoriteButton: UIButton) {
        let userID = UserDefaults.standard
        var arrayID = userID.object(forKey: UserDefaultConstant.forKey.rawValue) as? [Int] ?? [Int]()
        guard let gameID = self.gameID else { return }
        
        if isFavorite {
            arrayID = arrayID.filter({ $0 != gameID})
            isFavorite = !isFavorite
        }else{
            arrayID.append(gameID)
            isFavorite = !isFavorite
        }
        userID.set(arrayID, forKey: UserDefaultConstant.forKey.rawValue)
        favorite()
    }
    
    private func isFavoriteID() {
        let userID = UserDefaults.standard
        let arrayID = userID.object(forKey: UserDefaultConstant.forKey.rawValue) as? [Int] ?? [Int]()
        guard let gameID = self.gameID else { return }
        if arrayID.contains(gameID) {
            isFavorite = true
        }else{
            isFavorite = false
        }
    }
    
    private func propertyUI(game: GameDetailResult) {
        nameLabel.text =  game.name
        releaseLabel.text = "Release Date: \(game.released)"
        metacriticLabel.text = "Metacrtic Rate: \(game.metacritic)"
        descriptionLabel.text = game.descriptionRaw
        gameID = game.id
            
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(descriptionLabel)
        
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
        
        if let url =  URL(string: game.backgroundImage) {
            gameImage.af.setImage(withURL: url)
        }
    }
}

extension GameDetailVC: GameDetailViewDelegate {
    func handleOutPut(_ output: GameDetailPresenterOutPut) {
        switch output {
        case .gameDetailList(let game):
             propertyUI(game: game)
             isFavoriteID()
             favorite()
        case .gameDetailError(let error):
            errorMessage = error
        }
    }
}

extension GameDetailVC {
    private func makeImage() {
        gameImage.snp.makeConstraints { make in
             make
                .top
                .equalTo(view)
                .offset(0)
            make
                .left
                .right
                .equalTo(view)
                .offset(0)
            make
                .height
                .equalTo(view.frame.height/1.8)
        }
    }
    
    private func makeFavorite() {
        favoriteButton.snp.makeConstraints { make in
            make
                .bottom
                .equalTo(gameImage.snp.bottom)
                .offset(-20)
            make
                .right
                .equalTo(view)
                .offset(-20)
        }
    }
    
    private func makeName() {
        nameLabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(gameImage.snp.bottom)
                .offset(20)
            make
                .left
                .equalTo(view)
                .offset(20)
        }
    }
    
    private func makeRelease() {
        releaseLabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(nameLabel.snp.bottom)
                .offset(5)
            make
                .left
                .equalTo(view)
                .offset(20)
        }
    }
    
    private func makeMeta() {
        metacriticLabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(releaseLabel.snp.bottom)
                .offset(5)
            make
                .left
                .equalTo(view)
                .offset(20)
        }
    }
    
    private func makeScroll() {
        scrollView.snp.makeConstraints { make in
            make
                .top
                .equalTo(metacriticLabel.snp.bottom)
                .offset(20)
            make
                .left
                .equalTo(view)
                .offset(20)
            make
                .right
                .equalTo(view)
                .offset(-20)
            make
                .bottom
                .equalTo(view)
                .offset(-20)
        }
    }
}
