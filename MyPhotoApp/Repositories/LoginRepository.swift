//
//  LoginRepository.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 04/07/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import Combine

enum LoginError: Error {
    case genericError(String)
    case invalid(String)
    case encodingError
}

struct LoginRepository {
    
    func login(email: String, password: String) -> AnyPublisher<Account, LoginError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: try! request(email: email, password: password))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw LoginError.invalid("Email or Password are invalid")
                }
                return data
            }
            .decode(type: Account.self, decoder:  JSONDecoder())
            .mapError({ error -> LoginError in
                if error is LoginError {
                    return error as! LoginError
                }
                return LoginError.genericError(error.localizedDescription)
            })
            .eraseToAnyPublisher()
    }
    
    private func request(email: String, password: String) throws -> URLRequest {
        let loginParameters = LoginParameters(email: email, password: password)
        guard let encondedParams = try? JSONEncoder().encode(loginParameters) else {
            print("Error when encoding")
            throw LoginError.encodingError
        }
        
        var request = URLRequest(url: URL(string: "http://localhost:3000/oauth/token")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encondedParams
        return request
    }
}

struct LoginParameters: Codable {
    var email: String
    var password: String
    var grant_type: String = "password"
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
        case grant_type = "grant_type"
    }
}
