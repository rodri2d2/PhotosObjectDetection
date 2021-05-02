//
//  PhotoDetailViewModelDelegate.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 2/5/21.
//

import Foundation
import Vision

protocol PhotoDetailViewModelDelegate {
    func didReconizedObjects(recognizedObjects: [VNRecognizedObjectObservation])
}
