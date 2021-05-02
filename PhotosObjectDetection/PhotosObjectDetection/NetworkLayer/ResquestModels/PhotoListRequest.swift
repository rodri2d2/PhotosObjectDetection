//
//  PhotoListRequest.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation


struct PhotoListRequest: APIRequest {
    
    typealias Response   = [Photo]
    var http: HTTPMethod = .get
    var path: String     = APIPath.photoList.path
    var parameters: [String : String] = [:]
    
    init(){
        setParameters()
    }
    
    private mutating func setParameters(){
        parameters["page"]   = "2"
        parameters["limit"]  = "100"
    }
    
}
