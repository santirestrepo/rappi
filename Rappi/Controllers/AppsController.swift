//
//  AppsController.swift
//  Rappi
//
//  Created by Santiago Restrepo on 13/02/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class AppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let appCellId = "appCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SetupView
        setupCollectionView()
        setupNavBar()
        
        print(ApiService.shared.fetchData())
    }
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        
        // Register Cell
        collectionView?.register(AppCell.self, forCellWithReuseIdentifier: appCellId)
    }
    
    private func setupNavBar() {
        // NavBarTitle
        navigationItem.title = "Apps"
        
        // NavBar Buttons
        let categoriesBtn = UIBarButtonItem(title: "Categorias", style: .plain, target: self, action: #selector(handleCategories))
        navigationItem.leftBarButtonItems = [categoriesBtn]
    }
    
    func handleCategories() {
        let modalStyle = UIModalTransitionStyle.coverVertical
        let layout = UICollectionViewFlowLayout()
        let categoriesController = CategoriesController(collectionViewLayout: layout)
        categoriesController.modalTransitionStyle = modalStyle
        self.present(UINavigationController(rootViewController: categoriesController), animated: true, completion: nil)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appCellId, for: indexPath) as! AppCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
}
