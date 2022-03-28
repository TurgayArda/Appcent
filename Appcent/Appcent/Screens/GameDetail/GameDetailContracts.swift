//
//  GameDetailContracts.swift
//  Appcent
//
//  Created by ArdaSisli on 25.03.2022.
//

import Foundation

//MARK: - Interactor
protocol GameDetailInteractorProtocol {
    var delegate: GameDetailInteractorDelegate? { get set }
    func load()
}

enum GameDetailInteractorOutPut {
    case gameDetailList(GameDetailResult)
    case gameDetailError(String)
}

protocol GameDetailInteractorDelegate {
    func handleOutPut(_ output: GameDetailInteractorOutPut)
}

//MARK: - Presenter
protocol GameDetailPresenterProtocol {
    func load()
}

enum GameDetailPresenterOutPut {
    case gameDetailList(GameDetailResult)
    case gameDetailError(String)
}

//MARK: - View
protocol GameDetailViewDelegate {
    func handleOutPut(_ output: GameDetailPresenterOutPut)
}
