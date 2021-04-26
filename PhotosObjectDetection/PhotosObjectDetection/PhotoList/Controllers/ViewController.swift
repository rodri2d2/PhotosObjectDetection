//
//  ViewController.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - Class properties
    let viewModel: PhotoListViewModel
    
    // MARK: - Outlets
    private lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate   = self
        view.dataSource = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
        
    private lazy var searchBar:UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    
    // MARK: - Lifecycle
    
    init(viewModel: PhotoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.delegate = self
        self.viewModel.viewWasLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    
}



 // MARK: - Extension to setup view and styles
extension ViewController{
    
    private func setupViews(){
        setupSearchBar()
        setupNavigationController()
        setupCollectionView()
    }
    
    private func setupSearchBar(){
        self.searchBar.sizeToFit()
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.searchBar.placeholder = "looking for..."
    }
    
    private func setupNavigationController(){
        self.title = "Object Recogniser"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView = self.searchBar
    }
    
    private func setupCollectionView(){
        self.photoCollectionView.backgroundColor = .white
        self.view.addSubview(self.photoCollectionView)
        self.photoCollectionView.pin(to: self.view)
    }
}


// MARK: - Extension for UISearchBarDelegate
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    }
}



// MARK: - Extension for UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}



// MARK: - Extension for UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width  =  self.view.bounds.width - 32
        let height = self.view.bounds.height * 0.7 //60% of
        let size = CGSize(width: width, height: height)
    
        return size
    }
}




extension ViewController: PhotoListViewModelDelegate{
    func didFinishLoadPhotos() {
        
    }
}
