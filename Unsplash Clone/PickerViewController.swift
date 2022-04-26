//
//  ListViewController.swift
//  Unsplash Clone
//
//  Created by Александр Прайд on 26.04.2022.
//

import UIKit

class PickerViewController: UIViewController {
    
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavController()
        
    }
    
    // MARK: - Setup UI Elements
    
    private func setupNavController() {
        navigationItem.title = "Unsplash"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(collectionView)
        
        setupConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .gray
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: K.picker_ID_Cell)
        
        
    }
    
    private func setupConstraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }


}

// MARK: CollectionViewDelegate, CollectionViewDataSource

extension PickerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.picker_ID_Cell, for: indexPath)
        
        cell.backgroundColor = .yellow
        
        return cell
    }
    
    
    
    
}

