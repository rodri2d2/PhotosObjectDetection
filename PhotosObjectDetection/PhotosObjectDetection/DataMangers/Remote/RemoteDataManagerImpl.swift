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
    
    
    func fetchImage(imageUrl: String, id: String, size1: Int, size2: Int, completion: @escaping (Data) -> ()) {
        
        var sanatizedImageUrl = imageUrl.replacingOccurrences(of: "{0}", with: "\(id)")
        sanatizedImageUrl = sanatizedImageUrl.replacingOccurrences(of: "{size1}", with: "\(size1)")
        sanatizedImageUrl = sanatizedImageUrl.replacingOccurrences(of: "{size2}", with: "\(size2)")
        
        self.networkService.fetchImage(imageUrl: sanatizedImageUrl, completion: completion)
    }
}

