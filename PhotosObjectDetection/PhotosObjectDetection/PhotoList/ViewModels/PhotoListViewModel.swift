//
//  PhotoListViewModel.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation
import Vision
import CoreML
import UIKit

class PhotoListViewModel{
    
    // MARK: - Class properties
    let dataManager:               MainDataManager
    var delegate:                  PhotoListViewModelDelegate?
    private var lastLoad:          Date?
    
    //CellViewModels
    private var itemCellViewModel:         [ItemCellViewModel] = []
    private var filteredItemCellViewModel: [ItemCellViewModel] = []
    
    //ML model
    private lazy var yoloModel: VNCoreMLModel? = {
        let configuration = MLModelConfiguration()
        let model = try? VNCoreMLModel(for: YOLOv3(configuration: configuration).model)
        return model
    }()
    
    //ML Resquest
    private var arrayOfMLRequests: [VNCoreMLRequest] = []
    
    //TEST
    var photoInfomacion: Data = Data()
    var observation = VNRecognizedObjectObservation()
    
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
//            for item in itemCellViewModel{
//            }
        }else{
            if self.itemCellViewModel.count > 0{
                delegate?.didFinishLoadPhotos()
            } else {
                self.lastLoad = nil
                loadDataFromServer()
            }
        }
    }
    
    
    func loadDataFromSearch(searchText: String){
        for item in itemCellViewModel{
            if let image = item.photoData{
                doPerformMLRequest(imageData: image)
            }
        }
    }
    
    
    private func doPerformMLRequest(imageData: Data){
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                
                if let req = self.generateMLResquestArray(predicate: "bird"){
                    let handler = VNImageRequestHandler(data: imageData, options: [:])
                    try handler.perform([req])
                }
            } catch  {
                print("Error en el handler --> \(error.localizedDescription)")
            }
        }
    }
    
    
    
    private func prepareLoadedData(photListData: [Photo]){
        self.itemCellViewModel = photListData.map({ (photo) -> ItemCellViewModel in
            ItemCellViewModel(photo: photo, dataManager: self.dataManager)
        })
        self.delegate?.didFinishLoadPhotos()
    }
    
    private func generateMLResquestArray(predicate: String ) -> VNCoreMLRequest? {
        if let model = self.yoloModel{
            
            let request = VNCoreMLRequest(model: model) { visionResquestResult, error in
                if let _ = error {
                    print("resquest VN error !")
                    return
                }
                
                guard let results = visionResquestResult.results as? [VNRecognizedObjectObservation] else { return}
                
                guard let observation = results.first else {
                    return
                }
                
                if observation.labels.first?.identifier == predicate
                    &&
                   observation.confidence > 0.9 {
                    
                    print(observation.labels.first?.identifier ?? "nada")
                    print(observation.confidence)
                    
                }
            }
            return request
        }
        
        return nil
    }
    
    
}

// MARK: - Extension to serve Views/Controllers demands
extension PhotoListViewModel{
    
    func viewWasLoad(){
        loadDataFromServer()
        
        
        //        if lastLoad == nil {
        //            lastLoad = Date()
        //            loadDataFromServer()
        //        }else{
        //            let expirationTime: TimeInterval = 60 * 10
        //            guard let lastLoad = self.lastLoad else {  return }
        //            if Date().timeIntervalSince(lastLoad) < expirationTime {
        //                loadLocalData()
        //            }
        //        }
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
