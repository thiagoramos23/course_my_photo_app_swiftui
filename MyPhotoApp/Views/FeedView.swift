//
//  FeedView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 14/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI

func screenSize() -> CGSize {
    return UIScreen.main.bounds.size
}

struct FeedView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    init(feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBarView()
                Spacer()
                VStack {
                    if !self.feedViewModel.posts.isEmpty {
                        ScrollView {
                            ForEach(self.feedViewModel.posts) { post in
                                CardView(post: post)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            self.feedViewModel.loadPosts()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(feedViewModel: FeedViewModel())
    }
}

struct NavigationBarView: View {
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 8) {
                Button(action: {}) {
                    Image(systemName: "camera")
                    .resizable().frame(width: 25, height: 20)
                }
                .foregroundColor(.black)
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

struct RoundedImageView: View {
    var imageName: String = "woman"
    var cornerRadius: CGFloat = 5
    var body: some View {
        Image(imageName)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct CardView: View {
    var post: Post
    
    var body: some View {
        VStack {
            HStack {
                RoundedImageView(imageName: post.userImageUrl)
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
            RoundedImageView(imageName: post.postImageUrl, cornerRadius: 20)
                .padding(.leading)
                .padding(.trailing)
                .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 15, x: 5, y: 10)
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
