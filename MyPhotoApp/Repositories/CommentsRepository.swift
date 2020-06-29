//
//  CommentsRepository.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 28/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import Combine

struct CommentsRepository {
    
    func loadCommentsByPost(post: Post) -> AnyPublisher<[Comment], Error> {
        var request = URLRequest(url: URL(string: "\(baseUrl)/posts/\(post.id)/comments")!)
        request.setValue("Bearer JEMRiWH4R-smPatCdVA0LRpqOYFfb-c0421AS-AoP9c", forHTTPHeaderField: "Authorization")
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw NetworkError.requestError
                }
                return data
            }
            .decode(type: [Comment].self, decoder:  JSONDecoder())
            .eraseToAnyPublisher()
    }
}
