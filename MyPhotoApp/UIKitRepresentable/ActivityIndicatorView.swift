//
//  ActivityIndicatorView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 22/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        uiView.startAnimating()
    }
}
