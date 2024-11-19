//
//  FilterService.swift
//  CameraFilter
//
//  Created by Елена Воронцова on 19.11.2024.
//

import UIKit
import CoreImage
import RxSwift

final class FiltersService {
    private var context: CIContext
    
    init() {
        context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
    
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        let filter = CIFilter(name: "CICMYKHalftone")
        filter?.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            filter?.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let outputImage = filter?.outputImage,
               let outputImageExtent = filter?.outputImage?.extent,
               let cgImage = self.context.createCGImage(outputImage, from: outputImageExtent) {
                
                let processedImage = UIImage(cgImage: cgImage,
                                             scale: inputImage.scale,
                                             orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
    }
}
