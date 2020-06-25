//
//  PostRepository.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 24/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import Combine

let baseUrl = "http://localhost:3000/api/v1"

enum NetworkError: Error {
    case requestError
}

struct PostRepository {
        
    func loadPosts() -> AnyPublisher<[Post], Error> {
        var request = URLRequest(url: URL(string: "\(baseUrl)/posts")!)
        request.setValue("Bearer wc205k9tpUOZ364NInA6jIlh50TCTBR7QhNhpB1fBaI", forHTTPHeaderField: "Authorization")
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
            .decode(type: [Post].self, decoder:  JSONDecoder())
            .eraseToAnyPublisher()
    }
}
