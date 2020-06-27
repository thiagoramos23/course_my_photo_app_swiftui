//
//  CardView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 21/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var post: Post
    
    var body: some View {
        VStack {
            HStack {
                RoundedImageView(imageViewModel: ImageViewModel(imageUrl: post.userImageUrl))
                    .frame(width: 36, height: 25)
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text(post.username).font(.footnote).fontWeight(.bold)
                    HStack(alignment: .center) {
                        Text(post.location).font(.footnote).foregroundColor(.secondary)
                        Spacer()
                        Text(post.timePostedSinceNow).font(.caption).foregroundColor(.secondary)
                    }
                }
                .padding(.trailing)
            }
            RoundedImageView(imageViewModel: ImageViewModel(imageUrl: post.postImageUrl), cornerRadius: 20)
                .padding(.leading)
                .padding(.trailing)
                .shadow(color: Color.defaultShadowColor(), radius: 15, x: 5, y: 10)
                .frame(width: screenSize().width, height: 300)
            
            HStack(alignment: .center, spacing: 30) {
                Button(action: {}) {
                    HStack {
                        Image(systemName: "heart").font(Font.headline.weight(.semibold))
                        Text("\(post.likeCount)").font(.caption)
                    }
                    
                }.foregroundColor(.black)
                Button(action: {}) {
                    HStack {
                        Image(systemName: "bubble.right").font(Font.headline.weight(.semibold))
                        Text("\(post.commentCount)").font(.caption)
                    }
                    
                }.foregroundColor(.black)
                Spacer()
            }.padding()
            
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(post: Post(id: 1, userImageUrl: "woman", username: "mile_f", location: "London, Englang", timePostedSinceNow: "2 minutes ago", postImageUrl: "show", commentCount: 3, likeCount: 5))
    }
}
