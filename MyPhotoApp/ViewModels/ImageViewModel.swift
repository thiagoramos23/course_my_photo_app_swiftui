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

class ImageViewModel: ObservableObject {
    @Published var image: Image
    
    var viewState: ImageViewState
    
    var imageUrl       : String
    var imageRepository: ImageRepository
    
    var cancellable: AnyCancellable?
    
    init(imageUrl: String) {
        self.image    = Image("woman")
        self.imageUrl = imageUrl
        self.viewState = .loading
        self.imageRepository = ImageRepository()
    }
    
    func loadImage() {
        cancellable = imageRepository
            .loadImage(imageUrlString: imageUrl)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    self.viewState = .error
                    break
                case .finished:
                    self.viewState = .ready
                }
            }, receiveValue: { data in
                DispatchQueue.main.async {
                    self.image = Image(uiImage: UIImage(data: data)!)
                }
            })
    }
    
}
