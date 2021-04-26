//
//  RemoteDataManagerImpl.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation
class RemoteDataManagerImpl{
    
    // MARK: - Class Properties
    let networkService: NetworkService
    
    // MARK: - Lifecycle
    init(service: NetworkService) {
        self.networkService = service
    }
}


extension RemoteDataManagerImpl: RemoteDataManagerProtocol{
    
    func fetchPhotoList(completion: @escaping (Result<[Photo]?, Error>) -> ()) {
        let request = PhotoListRequest()
        self.networkService.fetchData(this: request, for: completion)
        
    }
    
    
    func fetchImage(imageUrl: String, completion: @escaping (Data) -> ()) {
        self.networkService.fetchImage(imageUrl: imageUrl, completion: completion)
    }
}

