//
//  PhotoDetailViewController.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 2/5/21.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    
    // MARK: - Class properties
    private let image: UIImage
    private let viewModel: PhotoDetailViewModel
    
    // MARK: - Outlets
    private lazy var photoView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: .zero, y: .zero, width: 200, height: 200))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    // MARK: - Lifecycle
    init(image: UIImage, viewModel: PhotoDetailViewModel) {
        self.image = image
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupOutlets()
        
    }

}

// MARK: - Setup Outlets and styles
extension PhotoDetailViewController{
    
    private func setupOutlets(){
        setupNavigationBar()
        setupPhotoImageView()
    }
    
    private func setupNavigationBar(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupPhotoImageView(){
        self.view.addSubview(photoView)
        self.photoView.pin(to: self.view)
        self.photoView.image = image
    }
    
}
