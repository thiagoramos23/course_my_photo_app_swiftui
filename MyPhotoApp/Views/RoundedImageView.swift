//
//  RoundedImageView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 21/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI

struct RoundedImageView: View {
    @ObservedObject var imageViewModel: ImageViewModel
    var cornerRadius: CGFloat = 5
        
    var activityView: some View {
        ActivityIndicatorView()
            .onAppear {
                self.imageViewModel.loadImage()
            }
    }
    
    var defaultImageView: some View {
        Image("woman")
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    var imageFromWeb: some View {
        self.imageViewModel
            .image
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    var showImageFromWeb: some View {
        switch self.imageViewModel.viewState {
            case .loading: return AnyView(activityView)
            case .ready: return AnyView(imageFromWeb)
            case .error: return AnyView(defaultImageView)
        }
    }
    
    var body: some View {
        showImageFromWeb
    }
}
struct RoundedImageView_Previews: PreviewProvider {
    static var imageViewModel: ImageViewModel = ImageViewModel(imageUrl: "woman")
    static var previews: some View {
        imageViewModel.viewState = .ready
        return RoundedImageView(imageViewModel: imageViewModel)
    }
}
