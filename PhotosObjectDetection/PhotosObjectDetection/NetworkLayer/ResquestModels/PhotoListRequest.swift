//
//  PhotoListRequest.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation


struct PhotoListRequest: APIRequest {
    var http: HTTPMethod = .get
    var path: String     = APIPath.main.path
    typealias Response   = [Photo]
}
