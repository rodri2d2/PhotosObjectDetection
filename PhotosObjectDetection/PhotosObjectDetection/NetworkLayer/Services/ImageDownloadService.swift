//
//  ImageDownloadService.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation

protocol ImageDownloadService {
    func fetchImage(imageUrl: String, completion: @escaping (_ imageData: Data)-> ())
}
