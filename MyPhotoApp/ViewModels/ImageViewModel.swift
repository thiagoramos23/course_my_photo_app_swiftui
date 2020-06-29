//
//  ImageViewModel.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 27/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

enum ImageViewState {
    case loading, ready, error
}

class ImageViewModel {
    
    var imageRepository: ImageRepository
    var cancellable: AnyCancellable?
    
//    
//    ImageViewModel.imageCache.setObject(data as NSData, forKey: imageUrl as NSString)
//    DispatchQueue.main.async {
//        self.data = data
//    }
    
    init() {
        self.imageRepository = ImageRepository()
    }
    
    func loadImage(imageUrl: String) -> AnyPublisher<Data, Never> {
        cancellable?.cancel()
        
        return imageRepository
            .loadImage(imageUrlString: imageUrl)
            .replaceError(with: Data())
            .eraseToAnyPublisher()
    }
    
}
