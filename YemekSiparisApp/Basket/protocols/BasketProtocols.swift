//
//  BasketProtocols.swift
//  YemekSiparisApp
//
//  Created by shenmali on 7.09.2022.
//

import Foundation

// Main Protocols
protocol ViewToPresenterBasketProtocol {
    
    var basketInteractor: PresenterToInteractorBasketProtocol? {get set}
    var basketView: PresenterToViewBasketProtocol? {get set}
    func fethFoods()
    func deleteFood(food_id: String)
}

protocol PresenterToInteractorBasketProtocol {
    
    var basketPresenter: InteractorToPresenterBasketProtocol? {get set}
    func fetch()
    func delete(food_id: String)
}

// Transfer Protocols
protocol InteractorToPresenterBasketProtocol {
    func dataTransferToPresenter(foodsList: Array<Cart>)
}

protocol PresenterToViewBasketProtocol {
    func dataTransferToView(foodsList: Array<Cart>)
}

// Router
protocol PresenterToRouterBasketProtocol {
    static func createModule(ref: BasketVC)
}
