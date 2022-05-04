//
//  PickerViewCell.swift
//  Unsplash Clone
//
//  Created by Александр Прайд on 04.05.2022.
//

import UIKit
import SDWebImage

class PickerViewCell: UICollectionViewCell {
    
    static let pickerIDCell = K.picker_ID_Cell
    private let photoImageView = UIImageView()
    private var checkMark = UIImageView()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["regular"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else {return}
            photoImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createPhotoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup UI elements
    
    // PhotoImageView
    private func createPhotoImageView() {
        photoImageView.backgroundColor = .purple
        photoImageView.contentMode = .scaleAspectFill
        
        setupPhotoImageView()
        
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // CheckMark
    private func createCheckMark() {
        let checkImage = UIImage(named: "checkMark")
        checkMark = UIImageView(image: checkImage)
        checkMark.alpha = 0
    }
    
    private func setupCheckMark() {
        addSubview(checkMark)
        checkMark.translatesAutoresizingMaskIntoConstraints = false
    }
}
