//
//  GameListProvider.swift
//  Appcent
//
//  Created by ArdaSisli on 23.03.2022.
//

import Foundation
import UIKit

class GameListProvider: NSObject, GameListProviderProtocol {
    var delegate: GameListProviderDelegate?
    var gameData: [GameResult] = []
    var isSearch = Bool()
    var SearchData: [GameResult] = []
}
// MARK: - Public Funcs

extension GameListProvider {
    func load(value: [GameResult]) {
        self.gameData = value
    }
    
    func isSearch(to search: Bool) {
        self.isSearch  = search
    }
    
    func searchData(to data: [GameResult]) {
        self.SearchData = data
    }
}

extension GameListProvider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearch {
            return SearchData.count
        }
        return gameData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameListCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? GameListCollectionViewCell else {
            return UICollectionViewCell()
        }
        if isSearch {
            cell.saveModel(value: SearchData[indexPath.row])
        } else {
            cell.saveModel(value: gameData[indexPath.row])
        }
           
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colums: CGFloat = 1
        let with = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 20)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        let width = (with - 50) / colums
        let height = width * 0.30
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isSearch {
            let routerSearch = SearchData[indexPath.row].id
            delegate?.selected(at: routerSearch)
        }else{
            let routerData = gameData[indexPath.row].id
            delegate?.selected(at: routerData)
        }
    }
}
