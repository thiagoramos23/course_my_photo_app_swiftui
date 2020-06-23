//
//  RoundedImageView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 21/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI

struct RoundedImageView: View {
    var imageName: String = "woman"
    var cornerRadius: CGFloat = 5
    var body: some View {
        Image(imageName)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
struct RoundedImageView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImageView()
    }
}
