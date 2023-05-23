//
//  Presenter.swift
//  YemekSiparisApp
//
//

import Foundation


class LoginPresenter: ViewToPresenterLoginProtocol {
    
    var loginView: PresenterToViewLoginProtocol?
    var loginInteractor: PresenterToInteractorLoginProtocol?
    
    func login(email: String, password: String) {
        loginInteractor?.loginPerson(email: email, password: password)
    }
    
}

extension LoginPresenter: InteractorToPresenterLoginProtocol {
    
    func dataTransferToPresenter(isSuccess: Bool) {
        loginView?.dataTransferToView(isSuccess: isSuccess)
    }
}
