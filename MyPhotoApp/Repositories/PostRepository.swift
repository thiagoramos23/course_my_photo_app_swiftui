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
        request.setValue(Account.loggedInAccessToken(), forHTTPHeaderField: "Authorization")
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.requestError
                }
                return data
            }
            .decode(type: [Post].self, decoder:  JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func uploadImage(imageDataToUpload: Data) -> AnyPublisher<Post, Error> {
        let urlRequest = createUploadRequest(imageDataToUpload: imageDataToUpload)
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.requestError
                }
                return data
            }
            .decode(type: Post.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func createUploadRequest(imageDataToUpload: Data) -> URLRequest {
        let imageBoundary = "Boundary-\(UUID().uuidString)"

        var request = URLRequest(url: URL(string: "\(baseUrl)/posts")!)
        request.httpMethod = "POST"
        request.setValue(Account.loggedInAccessToken(), forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(imageBoundary)", forHTTPHeaderField: "Content-Type")
        
        let httpBody = NSMutableData()
        httpBody.append(convertFileData(fieldName: "post[post_image]",
                                        fileName: "\(UUID().uuidString).png",
                                        mimeType: "image/png",
                                        fileData: imageDataToUpload,
                                        using: imageBoundary))

        httpBody.appendString("--\(imageBoundary)--")

        request.httpBody = httpBody as Data
        return request
    }
    
    private func convertFormField(named name: String, value: String, using boundary: String) -> String {
      var fieldString = "--\(boundary)\r\n"
      fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
      fieldString += "\r\n"
      fieldString += "\(value)\r\n"

      return fieldString
    }
    
    private func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
      let data = NSMutableData()

      data.appendString("--\(boundary)\r\n")
      data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
      data.appendString("Content-Type: \(mimeType)\r\n\r\n")
      data.append(fileData)
      data.appendString("\r\n")

      return data as Data
    }
}

extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
