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
    @ObservedObject var commentsViewModel: CommentsViewModel
    @State var show = false
    @State var activeIndex: Int = -1
    
    var imageViewModel: ImageViewModel
    
    init(feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
        self.imageViewModel = ImageViewModel()
        self.commentsViewModel = CommentsViewModel()
    }
    
    var feedListView: some View {
        GeometryReader { geo in
             ScrollView {
                ForEach(self.feedViewModel.posts.indices, id: \.self) { index in
                     GeometryReader { reader in
                        VStack {
                            CardView(post: self.$feedViewModel.posts[index], activeIndex: self.$activeIndex, show: self.$show, commentsViewModel: self.commentsViewModel, index: index, imageViewModel: self.imageViewModel)
                                .padding(.top, self.show ? 20 : 0)
                                .offset(y: self.feedViewModel.posts[index].showComment ? -reader.frame(in: .global).minY + 40 : 0)
                        }
                     }
                    .frame(height: self.show ? (geo.frame(in: .global).height + geo.frame(in: .global).minY) - 40 : 400)
                    .offset(x: self.activeIndex != index && self.show ? screenSize().width : 0)

                }
            }
            .frame(height: self.show ? screenSize().height + geo.frame(in: .global).minY : geo.frame(in: .global).height)
            .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.6))
            .edgesIgnoringSafeArea(.bottom)
        }
        
    }
    
    var loadingView: some View {
        VStack {
            Spacer()
            ActivityIndicatorView()
                .onAppear {
                    self.feedViewModel.loadPosts()
                }
            Spacer()
        }
    }
    
    var showView: some View {
        switch self.feedViewModel.viewState {
            case .loading: return AnyView(loadingView)
            default: return AnyView(feedListView)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBarView()
                    .offset(y: self.show ? -200 : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))

                showView
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var feedViewModel: FeedViewModel = FeedViewModel()
    static var previews: some View {
        feedViewModel.viewState = .ready
        feedViewModel.posts = postData
        return FeedView(feedViewModel: feedViewModel)
    }
}

let postData = [
    Post(id: 1, userImageUrl: "woman", username: "mile_f", location: "London, Englang", timePostedSinceNow: "2 minutes ago", postImageUrl: "show", commentCount: 3, likeCount: 5),
    Post(id: 1, userImageUrl: "woman", username: "carmen_sandiego", location: "Rio de Janeiro, Brazil", timePostedSinceNow: "10 minutes ago", postImageUrl: "friends", commentCount: 3, likeCount: 5),
    Post(id: 1, userImageUrl: "woman", username: "lucas_p", location: "London, England", timePostedSinceNow: "5 hours ago", postImageUrl: "lake", commentCount: 3, likeCount: 5),
    Post(id: 1, userImageUrl: "woman", username: "katia_s", location: "New York, USA", timePostedSinceNow: "1 day ago", postImageUrl: "trees", commentCount: 3, likeCount: 5),
    Post(id: 1, userImageUrl: "woman", username: "mile_f", location: "Berlin, Germany", timePostedSinceNow: "1 month ago", postImageUrl: "show", commentCount: 3, likeCount: 5)
]
