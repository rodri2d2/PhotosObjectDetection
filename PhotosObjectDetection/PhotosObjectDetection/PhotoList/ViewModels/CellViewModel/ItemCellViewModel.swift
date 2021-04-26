//
//  ItemCellViewModel.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation


class ItemCellViewModel{
    
    var delegate:    ItemCellViewModelDelegate?
    let authorText:  String
    let photo:       Photo
    var photoData:   Data?
    
    init(photo: Photo, dataManager: PhotoDataManagerProtocol){
        self.photo = photo
        self.authorText = self.photo.author
        
        let imageUrl = self.generatePhotoURL(size1: 300, size2: 300)

        dataManager.fetchImage(imageUrl: imageUrl) { (data) in
            self.photoData = data

            self.delegate?.didFinishLoadImageData()
        }
        
    }

    private func generatePhotoURL(size1: Int, size2: Int) -> String{
        
        var url = APIPath.photoPath.path
        url.append("\(self.photo.id)/")
        url.append("\(size1)/")
        url.append("\(size1)")
        
        return url
    }
}
