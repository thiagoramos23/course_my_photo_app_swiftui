//
//  CardView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 21/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @Binding var post: Post
    @Binding var activeIndex: Int
    @Binding var show: Bool
    @ObservedObject var commentsViewModel: CommentsViewModel
        
    var index: Int
    var imageViewModel: ImageViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    RoundedImageView(imageViewModel: self.imageViewModel, imageUrl: self.post.userImageUrl)
                        .frame(width: 36, height: 25)
                        .padding(.leading)
                    
                    VStack(alignment: .leading) {
                        Text(self.post.username).font(.footnote).fontWeight(.bold)
                        HStack(alignment: .center) {
                            Text(self.post.location).font(.footnote).foregroundColor(.secondary)
                            Spacer()
                            Text(self.post.timePostedSinceNow).font(.caption).foregroundColor(.secondary)
                        }
                    }
                    .padding(.trailing)
                }
                RoundedImageView(imageViewModel: self.imageViewModel, imageUrl: self.post.postImageUrl, cornerRadius: 20)
                    .padding(.leading)
                    .padding(.trailing)
                    .shadow(color: Color.defaultShadowColor(), radius: 15, x: 5, y: 10)
                    .frame(width: screenSize().width, height: 300)
                
                HStack(alignment: .center, spacing: 30) {
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "heart").font(Font.headline.weight(.semibold))
                            Text("\(self.post.likeCount)").font(.caption)
                        }
                        
                    }.foregroundColor(.black)
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "bubble.right").font(Font.headline.weight(.semibold))
                            Text("\(self.post.commentCount)").font(.caption)
                        }
                        
                    }.foregroundColor(.black)
                    Spacer()
                }
                .padding()
                
                CommentsView(post: self.post, commentsViewModel: self.commentsViewModel, imageViewModel: self.imageViewModel)
                    .opacity(self.post.showComment ? 1 : 0)
                    .animation(.easeInOut)
            }
            .onTapGesture {
                self.post.showComment.toggle()
                self.show.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var post = Post(id: 1, userImageUrl: "woman", username: "mile_f", location: "London, Englang", timePostedSinceNow: "2 minutes ago", postImageUrl: "show", commentCount: 3, likeCount: 5)
    static var previews: some View {
        CardView(post: .constant(post), activeIndex: .constant(-1), show: .constant(false), commentsViewModel: CommentsViewModel(), index: 1, imageViewModel: ImageViewModel())
    }
}
