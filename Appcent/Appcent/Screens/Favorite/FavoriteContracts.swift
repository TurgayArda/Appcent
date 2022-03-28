//
//  FavoriteContracts.swift
//  Appcent
//
//  Created by ArdaSisli on 26.03.2022.
//

import Foundation

//MARK: - Interactor
protocol FavoriteInteractorProtocol {
    var delegate: FavoriteInteractorDelegate? { get set }
    func load(path: Int)
}

enum FavoriteInteractorOutPut {
    case gameDetailList(GameDetailResult)
    case gameDetailError(String)
}

protocol FavoriteInteractorDelegate {
    func handleOutPut(_ output: FavoriteInteractorOutPut)
}

//MARK: - Presenter
protocol FavoritePresenterProtocol {
    func load(path: Int)
}

enum FavoritePresenterOutPut {
    case gameDetailList(GameDetailResult)
    case gameDetailError(String)
    case gameDetailTitle(String)
}

//MARK: - View
protocol FavoriteViewDelegate {
    func handleOutPut(_ output: FavoritePresenterOutPut)
}

//MARK - Provider
protocol FavoriteProviderProtocol {
    var delegate: FavoriteProviderDelegate? { get set }
    func load(value: GameDetailResult)
}

protocol FavoriteProviderDelegate {
    func selected(at select: Int)
}

//MARK: - Router
enum FavoriteRouterOutPut {
    case detail(Int)
}

protocol FavoriteRouterProtocol {
    func navigate(to route: FavoriteRouterOutPut)
}
