//
//  CommentsViewModel.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 28/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import Combine

enum CommentViewState {
    case loading, ready, error
}

class CommentsViewModel: ObservableObject {
    @Published var comments: [Comment]
    var commentsRepository: CommentsRepository
    var viewState: CommentViewState
    
    var cancellabe: AnyCancellable?
    
    init() {
        self.comments = []
        self.commentsRepository = CommentsRepository()
        self.viewState = .loading
    }
    
    func loadComments(post: Post) {
        cancellabe?.cancel()
        
        cancellabe = self.commentsRepository
            .loadCommentsByPost(post: post)
            .delay(for: 0.5, scheduler: DispatchQueue.global())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    self.viewState = .error
                    DispatchQueue.main.async {
                        self.comments = []
                    }
                    
                    break
                case .finished:
                    break
                }
            }) { comments in
                DispatchQueue.main.async {
                    self.viewState = .ready
                    self.comments = comments
                }
            }
    }
}
