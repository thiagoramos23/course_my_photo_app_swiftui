//
//  NavigationBarView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 21/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI

struct NavigationBarView: View {
    @Binding var showCamera: Bool
    var onDismiss: (() -> Void)?
    var modalContent: (() -> AnyView)
    
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 8) {
                Button(action: {
                    self.showCamera.toggle()
                }) {
                    Image(systemName: "camera")
                    .resizable().frame(width: 25, height: 20)
                }
                .foregroundColor(.black)
                .sheet(isPresented: self.$showCamera, onDismiss: onDismiss, content: modalContent)

                Spacer()
                Text("PhotoApp")
                    .font(Font.custom("Billabong", size: 26))
                Spacer()
                Button(action: {}) {
                    Image(uiImage: #imageLiteral(resourceName: "friends"))
                    .resizable()
                        .frame(width: 36, height: 36)
                    .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)

                }
                .foregroundColor(.red)
            }
            .padding()
            .background(Color.white)
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(showCamera: .constant(false), modalContent: {
            return AnyView(EmptyView())
        })
    }
}
