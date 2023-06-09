
//
//  HomeVC.swift
//  YemekSiparisApp
//
//  Created by shenmali on 7.09.2022.
//

import UIKit
import SwiftUI
import Kingfisher
import Firebase

class HomeVC: UIViewController {
    
    @IBOutlet weak var collectionViewSlider: UICollectionView!
    @IBOutlet weak var collectionViewProducts: UICollectionView!
    @IBOutlet weak var searchBarText: UISearchBar!
    let sliderImages = [
        "slider-1",
        "slider-2",
        "slider-3",
        "slider-4"
    ]
    var homePresenterObjc: ViewToPresenterHomeProtocol?
    var foodsList = [Foods]()
    var filteredFoodList = [Foods]()
    var currentUser = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegates
        collectionViewSlider.delegate = self
        collectionViewSlider.dataSource = self
        collectionViewProducts.delegate = self
        collectionViewProducts.dataSource = self
        searchBarText.delegate = self
        HomeRouter.createModule(ref: self)
        
        // For closed keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Products collectionView size settings
        let desing = UICollectionViewFlowLayout()
        desing.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        desing.minimumLineSpacing = 10
        desing.minimumInteritemSpacing = 10
        let width = collectionViewProducts.frame.size.width
        let cellWidth = (width - 30) / 2
        desing.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.5)
        collectionViewProducts.collectionViewLayout = desing
    }
    
    // Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        homePresenterObjc?.allFoods()
    }
    
    // Close keyboard func
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Go to basket button
    @IBAction func basketButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toBasket", sender: nil)
    }
    
    // Logout from app
    @IBAction func exitButtonFromApp(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Çıkmak istediğine emin misin?", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Vazgeç", style: .cancel)
        let okayButton = UIAlertAction(title: "Evet", style: .destructive) { _ in
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "toLogin", sender: nil)
            }catch {
                print(error.localizedDescription)
            }
            
        }
        alert.addAction(cancelButton)
        alert.addAction(okayButton)
        self.present(alert, animated: true)
    }
    
}

// CollectionView delegate import
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, BagButtonsProtocol {
    
  
    // Rows size
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionViewSlider:
            return sliderImages.count
        case collectionViewProducts:
            return foodsList.count
        default:
            return 0
        }
        
    }
    
    // Rows data settings
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        // Slider collectionView
        case collectionViewSlider:
            let image = sliderImages[indexPath.row]
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! HomeCollectionViewCell
            item.imageView.image = UIImage(named: image)
            item.sliderPageControl.numberOfPages = sliderImages.count
            return item
            
        // Product collectionView
        case collectionViewProducts:
            let food = foodsList[indexPath.row]
            let baseUrl = "http://kasimadalan.pe.hu/yemekler/resimler/"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCellProducts
            cell.imageView.image = UIImage(systemName: "photo")
            if let url = URL(string: "\(baseUrl)\(food.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    cell.imageView.kf.setImage(with: url)
                }
            }
            cell.foodNameLabel.text = food.yemek_adi
            cell.foodPriceLabel.text = "\(food.yemek_fiyat!) ₺"
            cell.itemsProtocol = self
            cell.indexPath = indexPath
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    // Go to detail page
    func detailButtonTapped(indexPath: IndexPath) {
        let food = foodsList[indexPath.row]
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.modalPresentationStyle = .fullScreen
        vc.products = food
        vc.productInfo = ProductDetailsList.productList[indexPath.row]
        show(vc, sender: self)
    }
    
}

// CollectionView size settings
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

// Data transfer from BasketPresenter
extension HomeVC: PresenterToViewHomeProtocol {
    
    func dataTransferToView(foodsList: Array<Foods>) {
        self.foodsList = foodsList
        self.filteredFoodList = foodsList
        self.collectionViewProducts.reloadData()
    }
}

extension HomeVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        foodsList = filteredFoodList.filter {
            if searchText.count != 0 {
                return $0.yemek_adi!.lowercased().contains(searchText.lowercased())
            }
            return true
        }
        collectionViewProducts.reloadData()
        
    }
}
