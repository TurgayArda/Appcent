//
//  GameListContracts.swift
//  Appcent
//
//  Created by ArdaSisli on 23.03.2022.
//

import Foundation

//MARK: - Interactor
protocol GameListInteractorProtocol {
    var delegate: GameListInteractorDelegate? { get set }
    func load()
}

enum GameListInteractorOutPut {
    case gameList([GameResult])
    case error(String)
}

protocol GameListInteractorDelegate {
    func handleOutPut(_ output: GameListInteractorOutPut)
}

//MARK: - Presenter
protocol GameListPresenterProtocol: AnyObject {
    func load()
}

enum GameListPresenterOutPut {
    case gameList([GameResult])
    case error(String)
    case title(String)
}

//MARK: - View
protocol GameListViewDelegate {
    func handleOutPut(_ output: GameListPresenterOutPut)
}

//MARK - Provider
protocol GameListProviderProtocol {
    var delegate: GameListProviderDelegate? { get set }
    func load(value: [GameResult])
    func isSearch(to search: Bool)
    func searchData(to data: [GameResult])
}

protocol GameListProviderDelegate {
    func selected(at select: Int)
}

//MARK: - Router
enum GameListRouterOutPut {
    case detail(Int)
}

protocol GameListRouterProtocol: AnyObject {
    func navigate(to route: GameListRouterOutPut)
}


