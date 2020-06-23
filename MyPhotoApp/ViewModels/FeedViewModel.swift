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
    case loading, ready
}


class FeedViewModel: ObservableObject {
    @Published var posts: [Post]
    
    var viewState: FeedViewState
    var cancellable: AnyCancellable?
    
    init() {
        self.posts = []
        self.viewState = .loading
    }
    
    func loadPosts() {
        let subject = PassthroughSubject<[Post], Never>()
        cancellable = subject
            .delay(for: 2, scheduler: RunLoop.main)
            .sink(receiveValue: { posts in
                self.posts = posts
                self.viewState = .ready
            })
        
        subject.send(postData)
    }
}
