//
//  APIPaths.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation


///Enum to avoid typo errors. Regiter path before use it.
enum APIPath: String {
    
    case main           = "https://picsum.photos/v2/list?page=1&limit=100"
    case photoDetail    = "https://picsum.photos/id/{0}/{size1}/{size2}"
    
    var path: String{ return self.rawValue }
    
}
