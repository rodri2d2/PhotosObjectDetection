//
//  RemotaDataManagerProtocol.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation

protocol RemoteDataManagerProtocol {
    func fetchPhotoList(completion: @escaping (Result<[Photo]?, Error>) -> ())
    
    
    //Image Service
    func fetchImage(imageUrl: String, id: String, size1: Int, size2: Int, completion: @escaping (Data) -> ())
}
