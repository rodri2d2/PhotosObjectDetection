//
//  MainDataManager.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation
class MainDataManager{
    
    // MARK: - Class properties
    let remoteManager: RemoteDataManagerProtocol
    
    // MARK: - Lifecycle
    init(remote: RemoteDataManagerProtocol) {
        self.remoteManager = remote
    }
}


// MARK: - Extension for PhotoDataManagerProtocol
extension MainDataManager: PhotoDataManagerProtocol{
    func fetchPhotoList(completion: @escaping (Result<[Photo]?, Error>) -> ()) {
        self.remoteManager.fetchPhotoList(completion: completion)
    }
}


// MARK: - Extension for 
extension MainDataManager: ImageDownloadService{
    func fetchImage(imageUrl: String, completion: @escaping (Data) -> ()) {
        self.remoteManager.fetchImage(imageUrl: imageUrl, completion: completion)
    }
}
