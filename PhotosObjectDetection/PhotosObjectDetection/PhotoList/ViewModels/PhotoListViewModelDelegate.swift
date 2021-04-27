//
//  PhotoListViewModelProtocol.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation


protocol PhotoListViewModelDelegate: AnyObject {
    func didFinishLoadPhotos()
}
