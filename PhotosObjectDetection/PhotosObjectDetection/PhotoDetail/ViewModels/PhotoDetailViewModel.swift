//
//  PhotoDetailViewModel.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 2/5/21.
//

import Foundation
import Vision

class PhotoDetailViewModel{
    // MARK: - Class properties
    var delegate: PhotoDetailViewModelDelegate?
    
    //ML model
    private lazy var yoloModel: VNCoreMLModel? = {
        let configuration = MLModelConfiguration()
        let model = try? VNCoreMLModel(for: YOLOv3(configuration: configuration).model)
        return model
    }()
    
    
    // MARK: - Class functionalities
    private func performPrediction(image: Data){
        if let model = self.yoloModel{
            do {
                let request = VNCoreMLRequest(model: model) { (resultRequest, error) in
                    
                    if let _ = error {
                        print("resquest VN error !")
                        return
                    }
                    
                    guard let results = resultRequest.results as? [VNRecognizedObjectObservation] else { return}
                    
//                    guard let observation = results.first else{
//                        return
//                    }
                    
                    var objects: [VNRecognizedObjectObservation] = []
                    for obs in results{
                        if obs.confidence > 0.8{
                            objects.append(obs)
                        }
                    }
                
                    self.delegate?.didReconizedObjects(recognizedObjects: objects)
//                    if observation.confidence > 0.6 {
//                        self.delegate?.didReconizedObjects(recognizedObjects: [observation])
//                    }
                }
                
                let handler = VNImageRequestHandler(data: image, options: [:])
                try handler.perform([request])
                
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
}



// MARK: - View demands
extension PhotoDetailViewModel{
    
    func viewWasLoad(image: Data){
        performPrediction(image: image)
    }
    
}
