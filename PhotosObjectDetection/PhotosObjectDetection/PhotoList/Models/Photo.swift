//
//  Photo.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation

struct Photo: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case url = "download_url"
    }
    
    let id: String
    let author: String
    let url: String
}
