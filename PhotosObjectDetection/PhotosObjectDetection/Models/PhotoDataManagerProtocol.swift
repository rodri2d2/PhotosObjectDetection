//
//  PhotoDataManagerProtocol.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation

protocol PhotoDataManagerProtocol: ImageDownloadService{
    func fetchPhotoList(completion: @escaping (Result<[Photo]?, Error>) -> ())
}
