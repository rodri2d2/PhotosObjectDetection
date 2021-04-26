//
//  ItemCell.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    // MARK: - Class properties
    var viewModel: ItemCellViewModel?{
        didSet{
            guard let viewModel = self.viewModel else { return }
            viewModel.delegate  = self
            self.authorLabel.text = viewModel.authorText
            
            if let imageData = viewModel.photoData{
                self.photoImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: - Outlets
    private lazy var mainContainer: UIView = {
       let view = UIView()
        view.frame = self.contentView.bounds
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(50)
        return view
    }()
    
    private lazy var textContainerView: UIView = {
        let view = UIView(frame: CGRect(x: .zero, y: .zero, width: self.contentView.frame.width, height: 150))
        return view
    }()
    
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    

    private lazy var authorLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = .white
        view.numberOfLines = 2
        view.textAlignment = .left
        view.lineBreakMode = .byTruncatingTail
        view.adjustsFontSizeToFitWidth = false
        return view
    }()
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupOutlets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorLabel.text     = nil
        self.photoImageView.image = nil
    }
    
}



extension ItemCell{
    private func setupOutlets(){
        setupMainContainer()
        setupPhotoImageView()
        setupTextContainerView()
        setupAuthorLabel()
        
    }
    
    private func setupMainContainer(){
        self.contentView.addSubview(mainContainer)
        self.mainContainer.pin(to: contentView)
        
    }
    
    private func setupPhotoImageView(){
        self.mainContainer.addSubview(photoImageView)
        photoImageView.pin(to: mainContainer)
    }
    
    //textContainerView
    private func setupTextContainerView(){
        self.mainContainer.addSubview(textContainerView)
        textContainerView.minimumSafetyConstraintBottom(on: contentView, withBottom: 0, leading: 0, trailing: 0)
        textContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        let gradient = getGradient()
        textContainerView.layer.addSublayer(gradient)

    }
    
    private func getGradient() -> CAGradientLayer{
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.textContainerGradientTop.cgColor,
                           UIColor.textContainerGradientMedium.cgColor,
                           UIColor.textContainerGradientBottom.cgColor
        ]
        
        gradient.frame = textContainerView.frame
        return gradient
    }
    
    private func setupAuthorLabel(){
        self.textContainerView.addSubview(authorLabel)
        authorLabel.minimumSafetyConstraintTop(on: textContainerView, withTop: 100, leading: 32, trailing: 16)
    }
    
}

// MARK: - Extension for ItemCellViewModelDelegate
extension ItemCell: ItemCellViewModelDelegate{
    func didFinishLoadImageData() {
        if let image = self.viewModel?.photoData{
            self.photoImageView.image = UIImage(data: image)
        }
    }
}
