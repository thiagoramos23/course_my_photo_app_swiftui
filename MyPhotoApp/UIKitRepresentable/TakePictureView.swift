//
//  TakePictureView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 05/07/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI
import UIKit

struct TakePictureView {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
      return Coordinator(isShown: $isShown, image: $image)
    }
}

extension TakePictureView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<TakePictureView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<TakePictureView>) {
    }
}
