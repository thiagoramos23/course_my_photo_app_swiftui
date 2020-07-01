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
    
    var getPostsRepository: GetPostsRepository = GetPostsRepository()
    
    var viewState: FeedViewState
    var cancellable: AnyCancellable?
    
    init() {
        self.posts = []
        self.errorMessage = ""
        self.viewState = .loading
    }
    
    func loadPosts() {
        cancellable = getPostsRepository
            .execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    self.viewState = .error
                    break
                case .finished: break
                }
            }, receiveValue: { posts in
                DispatchQueue.main.async {
                    self.viewState = .ready
                    self.posts = posts
                }
            })
    }
}
