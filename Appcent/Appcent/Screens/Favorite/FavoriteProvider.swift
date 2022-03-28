//
//  FavoriteProvider.swift
//  Appcent
//
//  Created by ArdaSisli on 26.03.2022.
//

import Foundation
import UIKit

class FavoriteProvider: NSObject, FavoriteProviderProtocol {
    
    var delegate: FavoriteProviderDelegate?
    var data: GameDetailResult?
    var dataTwo: [GameDetailResult] = []
}

extension FavoriteProvider {
    func load(value: GameDetailResult) {
        self.data = value
        guard let temp = data else { return }
        dataTwo.append(temp)
    }
}

extension FavoriteProvider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTwo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? FavoriteCollectionViewCell else {
            return UICollectionViewCell()
        }
            cell.saveModel(value: dataTwo[indexPath.row])
           return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colums: CGFloat = 1
        let with = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        let width = (with - 40) / colums
        let height = width * 0.35
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let routerData = dataTwo[indexPath.row].id
        delegate?.selected(at: routerData)
    }
}
