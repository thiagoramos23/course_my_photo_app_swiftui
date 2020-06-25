//
//  FeedViewModel.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 21/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

enum FeedViewState {
    case loading, ready, error
}


class FeedViewModel: ObservableObject {
    @Published var posts: [Post]
    @Published var errorMessage: String
    
    var viewState: FeedViewState
    var cancellable: AnyCancellable?
    var postRepository: PostRepository = PostRepository()
    
    init() {
        self.posts = []
        self.errorMessage = ""
        self.viewState = .loading
    }
    
    func loadPosts() {
//        let subject = PassthroughSubject<[Post], Never>()
//        cancellable = subject
//            .delay(for: 2, scheduler: RunLoop.main)
//            .sink(receiveValue: { posts in
//                self.posts = posts
//                self.viewState = .ready
//            })
        
//        subject.send(postData)
        
        cancellable = postRepository.loadPosts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.viewState = .ready
                case.failure(let error):
                    self.viewState = .error
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }) { posts in
                DispatchQueue.main.async {
                    self.posts = posts
                }
            }
    }
}
