//
//  ForgetPasswordPresenter.swift
//  YemekSiparisApp
//
//  Created by shenmali on 7.09.2022.
//

import Foundation


class ForgetPasswordPresenter: ViewToPresenterForgetPasswordProtocol {
    
    var forgetPasswordInteractor: PresenterToInteractorForgetPasswordProtocol?

    func reset(email: String) {
        forgetPasswordInteractor?.resetPassword(email: email)
    }
    
    
}
