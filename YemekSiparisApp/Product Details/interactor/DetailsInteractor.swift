//
//  DetailsInteractor.swift
//  YemekSiparisApp
//
//  Created by shenmali on 7.09.2022.
//

import Foundation
import Alamofire


class DetailInteractor: PresenterToInteractorDetailsProtocol {
    
    var detailPresenter: InteractorToPresenterDetailsProtocol?
    
    func addOrder(food_name: String, food_image_name: String, food_price: Int, food_order_count: Int, currentUser: String) {
        let params: Parameters = ["yemek_adi": food_name, "yemek_resim_adi": food_image_name, "yemek_fiyat": food_price, "yemek_siparis_adet": food_order_count, "kullanici_adi": currentUser]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print(result)
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}
