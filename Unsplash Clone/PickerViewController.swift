//
//  ListViewController.swift
//  Unsplash Clone
//
//  Created by Александр Прайд on 26.04.2022.
//

import UIKit

class PickerViewController: UIViewController {
    
    var collectionView: UICollectionView! = nil
    var networkDataFetcher = NetworkDataFetcher()
    private var timer = Timer()
    private var photos = [UnsplashPhoto]()
    private let itemsPerRow: CGFloat = 2
    private let sectionsInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavController()
        setupSearchBar()
        
    }
    
    // MARK: - Setup UI Elements
    
    private func setupNavController() {
        navigationItem.title = "UnClone"
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
        
        collectionView.backgroundColor = .black
        
        collectionView.register(PickerViewCell.self, forCellWithReuseIdentifier: K.picker_ID_Cell)
        
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        
        
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.delegate = self
        
        searchController.searchBar.tintColor = .white
        searchController.searchBar.isTranslucent = true
        
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
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.picker_ID_Cell, for: indexPath) as! PickerViewCell
        
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        
        return cell
    }
}

// MARK: UISearchBarDelegatte
extension PickerViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.networkDataFetcher.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.results
                self?.collectionView.reloadData()
            }
        })
       
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension PickerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // достаём фотографию из всех фотографий
        let photo = photos[indexPath.item]
        // смотрим сколько отступов между объектами
        // две ячайки и три расстояния
        let paddingSpace = sectionsInserts.left * (itemsPerRow + 1)
        // сколько всего ширины имеется в доступе
        // из ширины экрана вычитаем резльтат paddingSplace
        let availableWidth = view.frame.width - paddingSpace
        // какую ширину мы предоставляем одной строчке
        // вся доступная ширина делится на количество ячеек, которые мы хотим видеть
        let widthPerItem = availableWidth / itemsPerRow
        // высчитываем высоту картинки, исходят из соотношения её сторон
        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionsInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionsInserts.left
    }
}

