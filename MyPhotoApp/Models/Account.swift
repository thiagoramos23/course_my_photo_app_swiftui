//
//  Account.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 04/07/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation


class Account: NSObject, NSCoding, Decodable {
    static let LOGGED_IN_ACCOUNT = "loggedInAccount"
    
    var accessToken: String
    var tokenType: String
        
    required init?(coder: NSCoder) {
        self.accessToken = coder.decodeObject(forKey: "accessToken") as? String ?? ""
        self.tokenType   = coder.decodeObject(forKey: "tokenType") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.accessToken, forKey: "accessToken")
        coder.encode(self.tokenType, forKey: "tokenType")
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType   = "token_type"
    }
}

