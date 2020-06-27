//
//  ImageRepository.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 27/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import Combine

struct ImageRepository {
    
    func loadImage(imageUrlString: String) -> AnyPublisher<Data, Error> {
        URLSession
            .shared
            .dataTaskPublisher(for: URL(string: imageUrlString)!)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw NetworkError.requestError
                }
                return data
            }
            .eraseToAnyPublisher()
    }
}
