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
    
    func postImage(image: UIImage?) {
        guard let imageTaken = image else {
            return
        }
        
        if let imageData = imageTaken.pngData() {
            cancellable = self.postRepository
                .uploadImage(imageDataToUpload: imageData)
                .receive(on:  RunLoop.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Finished")
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                        break
                    }
                }, receiveValue: { post in
                    print(post)
                })
        }
    }
}
