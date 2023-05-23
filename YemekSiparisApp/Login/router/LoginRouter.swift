//
//  LoginRouter.swift
//  YemekSiparisApp
//
//

import Foundation


class LoginRouter: PresenterToRouterLoginProtocol {
    
    static func createModule(ref: LoginVC) {
        let presenter = LoginPresenter()
        
        // View
        ref.loginPresenterObject = presenter
        
        // Presenter
        ref.loginPresenterObject?.loginInteractor = LoginInteractor()
        ref.loginPresenterObject?.loginView = ref
        
        // Interactor
        ref.loginPresenterObject?.loginInteractor?.loginPresenter = presenter
    }
    
    
 
}
 
