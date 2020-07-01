//
//  RoundedImageView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 21/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI

struct RoundedImageView: View {
    var imageName: String = "lake"
    var cornerRadius: CGFloat = 5
    
    var url: String
    
    @ObservedObject var imageViewModel: ImageViewModel = ImageViewModel()
    
    init(url: String) {
        self.url = url
    }
    
    var loadingView: some View {
        ActivityIndicatorView()
            .onAppear {
                self.imageViewModel.loadImage(url: self.url)
            }
    }
    
    var imageView: some View {
        Image(uiImage: self.imageViewModel.data.count == 0 ? UIImage(named: imageName)! : UIImage(data: self.imageViewModel.data)!)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    var showView: some View {
        switch self.imageViewModel.imageViewState {
            case .loading: return AnyView(loadingView)
            case .ready: return AnyView(imageView)
        }
    }
        
    var body: some View {
        showView
    }
}

struct RoundedImageView_Previews: PreviewProvider {
    static var previews: some View {
        return RoundedImageView(url: "woman")
    }
}
