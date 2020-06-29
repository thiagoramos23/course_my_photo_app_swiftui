//
//  RoundedImageView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 21/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI
import Combine

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

struct RoundedImageView: View {
    var imageViewModel: ImageViewModel
    var cornerRadius: CGFloat = 5
    var imageUrl: String
    @State var image: Image?
    
    @State var cancellable: AnyCancellable?
                
    init(imageViewModel: ImageViewModel, imageUrl: String, cornerRadius: CGFloat = 5) {
        self.imageViewModel = imageViewModel
        self.imageUrl       = imageUrl
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        Group {
            if(self.image == nil) {
                Text("Loading...")
                    .onAppear {
                        let cachedData = ImageCache.getFromCache(imageUrl: self.imageUrl)
                        if cachedData.count > 0 {
                            DispatchQueue.main.async {
                                self.image = Image(uiImage: UIImage(data: cachedData)!)
                            }
                            
                        } else {
                            self.cancellable = self.imageViewModel.loadImage(imageUrl: self.imageUrl)
                            .sink { data in
                                DispatchQueue.main.async {
                                    self.image = Image(uiImage: UIImage(data: data)!)
                                }
                                ImageCache.setToCache(data: data, imageUrl: self.imageUrl)
                            }
                        }
                }

            } else {
                self.image!
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: self.cornerRadius))
            }
        }
    }
}
struct RoundedImageView_Previews: PreviewProvider {
    static var previews: some View {
        return RoundedImageView(imageViewModel: ImageViewModel(), imageUrl: "woman")
    }
}
