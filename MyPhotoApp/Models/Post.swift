//
//  Post.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 22/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation

struct Post: Identifiable {
    var id: Int
    var userImageUrl: String
    var username: String
    var location: String
    var timePostedSinceNow: String
    var postImageUrl: String
    var commentCount: Int
    var likeCount: Int
    
    init(id: Int, userImageUrl: String, username: String, location: String, timePostedSinceNow: String, postImageUrl: String, commentCount: Int, likeCount: Int) {
        self.id = id
        self.userImageUrl = userImageUrl
        self.username = username
        self.location = location
        self.timePostedSinceNow = timePostedSinceNow
        self.postImageUrl = postImageUrl
        self.commentCount = commentCount
        self.likeCount = likeCount
    }
}

extension Post: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id                 = "id"
        case userImageUrl       = "user_image_url"
        case username           = "username"
        case location           = "location"
        case timePostedSinceNow = "time_posted_since_now"
        case postImageUrl       = "post_image_url"
        case commentCount       = "comment_count"
        case likeCount          = "like_count"
    }
}
