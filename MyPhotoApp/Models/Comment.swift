//
//  Comment.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 27/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation

struct Comment: Identifiable {
    var id: Int
    var user_id: Int
    var post_id: Int
    var username: String
    var userImageUrl: String
    var commentText: String
}

extension Comment: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id                 = "id"
        case user_id            = "user_id"
        case post_id            = "post_id"
        case userImageUrl       = "user_image_url"
        case username           = "username"
        case commentText        = "comment_text"
    }
}
