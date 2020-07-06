//
//  CommentsView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 28/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI

struct CommentsView: View {
    @Binding var post: Post
    @ObservedObject var commentsViewModel: CommentsViewModel
    var imageViewModel: ImageViewModel
        
    var showCommentsView: some View {
        switch self.commentsViewModel.viewState {
            case .loading: return AnyView(activityView)
            case .error: return AnyView(errorView)
            case .ready: return AnyView(commentsView)
        }
    }
    
    var errorView: some View {
        Text("Error loading the comments")
    }
    
    var activityView: some View {
        ActivityIndicatorView()
            .onAppear {
                self.commentsViewModel.loadComments(post: self.post)
            }
    }
    
    var commentsView: some View {
        VStack {
            ScrollView {
                ForEach(self.commentsViewModel.comments) { comment in
                    CommentView(comment: comment, imageViewModel: self.imageViewModel)
                }
            }
        }
        .onDisappear {
            self.commentsViewModel.viewState = .loading
        }
    }
    
    var body: some View {
        showCommentsView
    }
}

struct CommentsView_Previews: PreviewProvider {
    static let post = Post(id: 1, userImageUrl: "woman", username: "mile_f", location: "London, Englang", timePostedSinceNow: "2 minutes ago", postImageUrl: "show", commentCount: 3, likeCount: 5)
    static var previews: some View {
        CommentsView(post: .constant(post), commentsViewModel: CommentsViewModel(), imageViewModel: ImageViewModel())
    }
}
