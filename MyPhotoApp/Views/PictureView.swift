//
//  PictureView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 05/07/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI

struct PictureView: View {
    @Binding var showCamera: Bool
    @Binding var image: UIImage?
    
    var body: some View {
        TakePictureView(isShown: $showCamera, image: $image)
    }
}

struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView(showCamera: .constant(false), image: .constant(nil))
    }
}
