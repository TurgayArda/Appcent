//
//  GameListCollectionViewCell.swift
//  Appcent
//
//  Created by ArdaSisli on 23.03.2022.
//

import UIKit
import AlamofireImage
import SnapKit

class GameListCollectionViewCell: UICollectionViewCell {
        
        private lazy var gameRating: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 15)
            label.textAlignment = .center
            label.textColor = .black
            addSubview(label)
            return label
        }()
        
        private lazy var gameimage: UIImageView = {
            let image = UIImageView()
            image.clipsToBounds = true
            image.backgroundColor = .white
            contentView.addSubview(image)
            return image
        }()
    
        private lazy var gameName: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 15)
            label.textAlignment = .center
            label.textColor = .black
            addSubview(label)
            return label
        }()
        
        enum Identifier: String {
            case path = "Cell"
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configure() {
            makeImage()
            makeName()
            makeRating()
        }
        
        func saveModel(value: GameResult) {
            gameRating.text = "Rating: \(value.rating) - Released: \(value.released) "
            gameimage.af.setImage(withURL: URL(string: value.backgroundImage)!)
            gameName.text = value.name
        }
    }

    extension GameListCollectionViewCell {
        private func makeImage() {
            gameimage.snp.makeConstraints { make in
                make
                    .top
                    .equalTo(contentView.safeAreaLayoutGuide)
                    .offset(5)
                make
                    .left
                    .equalTo(contentView)
                    .offset(10)
                make
                    .height
                    .equalTo(100)
                make
                    .width
                    .equalTo(100)
            }
        }
        
        private func makeName() {
            gameName.snp.makeConstraints { make in
                make
                    .top
                    .equalTo(contentView.safeAreaLayoutGuide)
                    .offset(5)
                make
                    .left
                    .equalTo(gameimage.snp.right)
                    .offset(10)
            }
        }
        
        private func makeRating() {
            gameRating.snp.makeConstraints { make in
                make
                    .top
                    .equalTo(gameName.snp.bottom)
                    .offset(5)
                make
                    .left
                    .equalTo(gameimage.snp.right)
                    .offset(10)
        }
    }
}
