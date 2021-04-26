//
//  PhotoListViewModel.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation


class PhotoListViewModel{
    
    // MARK: - Class properties
    let dataManager: MainDataManager
    var delegate:    PhotoListViewModelDelegate?
    private var itemCellViewModel: [ItemCellViewModel] = []
    
    init(dataManager: MainDataManager) {
        self.dataManager = dataManager
    }
    
    
    private func loadData(){
        dataManager.fetchPhotoList { (result) in
            switch result{
            case .success(let response):
                if let photos = response {
                    self.prepareLoadedData(photListData: photos)
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func prepareLoadedData(photListData: [Photo]){
        self.itemCellViewModel = photListData.map({ (photo) -> ItemCellViewModel in
            ItemCellViewModel(photo: photo, dataManager: self.dataManager)
        })
    }
    
}

// MARK: - Extension to serve Views/Controllers demands
extension PhotoListViewModel{
    

    func viewWasLoad(){
        loadData()
    }
    
    func cellForItemAt(indexPath: IndexPath) -> ItemCellViewModel?{
        guard indexPath.row < itemCellViewModel.count else { return nil }
        return itemCellViewModel[indexPath.row]
    }
    
    func numberOfItemsInSection() -> Int {
        return self.itemCellViewModel.count
    }
}
