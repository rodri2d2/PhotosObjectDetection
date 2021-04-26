//
//  ItemCellViewModel.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation


class ItemCellViewModel{
    
    var delegate:   ItemCellViewModelDelegate?
    var photo:      Data?
    let authorText: String
    
    
    
    init(photo: Photo, dataManager: PhotoDataManagerProtocol){
        self.authorText = photo.author
        dataManager.fetchImage(imageUrl: photo.url, id: photo.id, size1: 300, size2: 300) { (data) in
            DispatchQueue.main.async {
                self.photo = data
                self.delegate?.didFinishLoadImageData()
            }
        }
    }
    
}
