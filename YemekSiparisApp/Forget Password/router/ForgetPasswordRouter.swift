//
//  ForgetPasswordRouter.swift
//  YemekSiparisApp
//
//  Created by shenmali on 7.09.2022.
//

import Foundation


class ForgerPasswordRouter: PresenterToRouterForgetPasswordProtocol {
    
    static func createModul(ref: ForgetPasswordVC) {
        ref.forgerPasswordPresenterObject = ForgetPasswordPresenter()
        ref.forgerPasswordPresenterObject?.forgetPasswordInteractor = ForgerPasswordInteractor()
    }
}
