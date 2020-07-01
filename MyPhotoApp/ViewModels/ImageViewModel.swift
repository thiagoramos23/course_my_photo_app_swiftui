//
//  ImageViewModel.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 29/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import Combine

enum ImageViewState {
    case loading, ready
}

class ImageViewModel: ObservableObject {
    @Published var data: Data
    var imageViewState: ImageViewState
    
    var imageRepository: ImageRepository = ImageRepository()
    
    init() {
        self.data = Data()
        self.imageViewState = .loading
    }
    
    var cancellable: AnyCancellable?
    
    func loadImage(url: String) {
        let cachedData = ImageCache.getFromCache(imageUrl: url)
        if cachedData.count > 0 {
            self.data = cachedData
            return
        }
        
        cancellable = imageRepository
        .loadImage(url: url)
        .replaceError(with: Data())
            .sink { data in
                DispatchQueue.main.async {
                    self.imageViewState = .ready
                    self.data = data
                }
                ImageCache.setToCache(data: data, imageUrl: url)
        }
    }
}

struct ImageCache {
    static let imageCache: NSCache = NSCache<NSString, NSData>()
    
    static func setToCache(data: Data, imageUrl: String) {
        ImageCache.imageCache.setObject(data as NSData, forKey: imageUrl as NSString)
    }
    
    static func getFromCache(imageUrl: String) -> Data {
        if let data = ImageCache.imageCache.object(forKey: imageUrl as NSString) {
            return data as Data
        }
        
        return Data()
    }
}
