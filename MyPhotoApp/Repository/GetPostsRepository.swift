//
//  GetPostsRepository.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 29/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import Combine

struct GetPostsRepository {
    
    func execute() -> AnyPublisher<[Post], Error> {
        var request = URLRequest(url: URL(string: "http://localhost:3000/api/v1/posts")!)
        request.setValue("Bearer CvejCjicyZVIUrDI2lf4ubc_MwFL-JyaT8-TKfhqOaw", forHTTPHeaderField: "Authorization")
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
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
