//
//  PhotoListViewModel.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation
import Vision
import CoreML


class PhotoListViewModel{
    
    // MARK: - Class properties
    let dataManager:               MainDataManager
    var delegate:                  PhotoListViewModelDelegate?
    private var lastLoad:          Date?
    private var itemCellViewModel: [ItemCellViewModel] = []
    

    //ML model
    private lazy var yoloModel: VNCoreMLModel? = {
        let configuration = MLModelConfiguration()
        let model = try? VNCoreMLModel(for: YOLOv3(configuration: configuration).model)
        return model
    }()
    
    init(dataManager: MainDataManager) {
        self.dataManager = dataManager
    }
    
    
    private func loadDataFromServer(){
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
    
    private func loadLocalData(predicate: String = ""){
        
        if !predicate.isEmpty {
            for item in itemCellViewModel{
                searchInsideImage(item: item, predicate: predicate)
            }
        }else{
            if self.itemCellViewModel.count > 0{
                delegate?.didFinishLoadPhotos()
            } else {
                self.lastLoad = nil
                loadDataFromServer()
            }
        }
    }
    
    
    private func loadDataFromSearch(searchText: String){
        
    }
    
    private func prepareLoadedData(photListData: [Photo]){
        self.itemCellViewModel = photListData.map({ (photo) -> ItemCellViewModel in
            ItemCellViewModel(photo: photo, dataManager: self.dataManager)
        })
        self.delegate?.didFinishLoadPhotos()
    }
    
    private func searchInsideImage(item: ItemCellViewModel, predicate: String){
        
//        var newArrayOfItemCellViewModel: [ItemCellViewModel]  = []
        
        
  
//            do {
//
//                //
//                let request = VNCoreMLRequest(model: self.yoloModel!) { (reqResult, error) in
//                    if let _ = error {
//                        print("resquest VN error !")
//                        return
//                    }
//
//                    guard let results = reqResult.results as? [VNRecognizedObjectObservation] else { return}
//
//                    guard let observation = results.first else{
//                        return
//                    }
//
//                    if observation.labels.first?.identifier == predicate{
//                        newArrayOfItemCellViewModel.append(ItemCellViewModel(photo: item.photo, dataManager: self.dataManager))
//                    }
//                }
//                //
//                if let image = item.photoData{
//                    let handler = VNImageRequestHandler(data: image, options: [:])
//                    //
//                    try handler.perform([request])
//                }
//
//
//            } catch {
//
//            }
//
//
//
////        if newArrayOfItemCellViewModel.count > 0 {
////            self.itemCellViewModel.removeAll()
////            self.itemCellViewModel = newArrayOfItemCellViewModel
////            self.delegate?.didFinishLoadPhotos()
////        }
////
//
    }
    
    
    
    
    
}

// MARK: - Extension to serve Views/Controllers demands
extension PhotoListViewModel{
    
    func viewWasLoad(){
        
        if lastLoad == nil {
            lastLoad = Date()
            loadDataFromServer()
        }else{
            let expirationTime: TimeInterval = 60 * 10
            guard let lastLoad = self.lastLoad else {  return }
            if Date().timeIntervalSince(lastLoad) < expirationTime {
                loadLocalData()
            }
        }
        
        
    }
    
    func numberOfItemsInSection() -> Int {
        return self.itemCellViewModel.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> ItemCellViewModel?{
        guard indexPath.row < itemCellViewModel.count else { return nil }
        return itemCellViewModel[indexPath.row]
    }
    
    func searchForThis(text: String){
        if text.count >= 3{
            loadLocalData(predicate: text)
        }
    }
    
}
