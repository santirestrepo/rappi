//
//  CategoriesController.swift
//  Rappi
//
//  Created by Santiago Restrepo on 13/02/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class CategoriesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let categoryCellId = "categoryCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SetupView
        setupCollectionView()
        setupNavBar()
    }
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        
        // Register Cell
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellId)
    }
    
    private func setupNavBar() {
        // NavBarTitle
        navigationItem.title = "Categorias"
        
        // NabVarButtons
        let appsBtn = UIBarButtonItem(title: "Apps", style: .plain, target: self, action: #selector(handleApps))
        navigationItem.leftBarButtonItems = [appsBtn]
    }
    
    func handleApps() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath)
        cell.backgroundColor = UIColor.cyan
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
}
