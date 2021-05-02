//
//  PhotoDetailViewController.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 2/5/21.
//

import UIKit
import Vision

class PhotoDetailViewController: UIViewController {
    
    // MARK: - Class properties
    private let image: UIImage
    private let viewModel: PhotoDetailViewModel
    
    // MARK: - Outlets
    private lazy var photoView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: .zero, y: .zero, width: 200, height: 200))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    // MARK: - Lifecycle
    init(image: UIImage, viewModel: PhotoDetailViewModel) {
        self.image = image
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        self.viewModel.delegate = self
        
        self.viewModel.viewWasLoad(image: image.jpegData(compressionQuality: CGFloat(1))!)
        //
        setupOutlets()
        
    }

}

// MARK: - Setup Outlets and styles
extension PhotoDetailViewController{
    
    private func setupOutlets(){
        setupNavigationBar()
        setupPhotoImageView()
    }
    
    private func setupNavigationBar(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupPhotoImageView(){
        self.view.addSubview(photoView)
        self.photoView.pin(to: self.view)
        self.photoView.image = image
    }
    
}


// MARK: - Extension for Drawing recognized Objects
extension PhotoDetailViewController{
    
    private func drawDetectecObjectBounds(recognizedObjects: [VNRecognizedObjectObservation]){
        DispatchQueue.main.async {
                    guard let image = self.photoView.image else {return}
                    
                    let imageSize = image.size
                    var imageTransform = CGAffineTransform.identity.scaledBy(x: 1, y: -1).translatedBy(x: 0, y: -imageSize.height)
                    imageTransform = imageTransform.scaledBy(x: imageSize.width, y: imageSize.height)
                    UIGraphicsBeginImageContextWithOptions(imageSize, true, 0)
                   
                    let graphicsContext = UIGraphicsGetCurrentContext()
                    image.draw(in: CGRect(origin: .zero, size: imageSize))
                    graphicsContext?.saveGState()
                    graphicsContext?.setLineJoin(.round)
                    graphicsContext?.setLineWidth(4.0)
                    graphicsContext?.setFillColor(red: 0, green: 1, blue: 0, alpha: 0.3)
                    graphicsContext?.setStrokeColor(UIColor.green.cgColor)
                    
                    recognizedObjects.forEach { (observation) in
                    
                        let observationBounds = observation.boundingBox.applying(imageTransform)
                        graphicsContext?.addRect(observationBounds)
                    }
//                    if objectsName.count == 0 {
//                        self.labelExample.text = "No se han encontrado objetos"
//                    } else {
//                        self.labelExample.text = objectsName
//                    }
                    graphicsContext?.drawPath(using: CGPathDrawingMode.fillStroke)
                    graphicsContext?.restoreGState()
                    
                    let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()

                    self.photoView.image = drawnImage
                }
    }
    
}


// MARK: - Extension for PhotoDetailViewModelDelegate
extension PhotoDetailViewController: PhotoDetailViewModelDelegate{
    func didReconizedObjects(recognizedObjects: [VNRecognizedObjectObservation]) {
        self.drawDetectecObjectBounds(recognizedObjects: recognizedObjects)
    }
}
