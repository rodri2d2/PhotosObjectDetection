//
//  ImageDownloadService.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation

protocol ImageDownloadService {
    func fetchImage(imageUrl: String, id: String, size1: Int, size2: Int, completion: @escaping (_ imageData: Data)-> ())
}
