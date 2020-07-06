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
    var loggedIn: Bool = false
            
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
    
    func storeAccount() {
        self.loggedIn = true
        if let archivedAccount = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false) {
            UserDefaults.standard.set(archivedAccount, forKey: Account.LOGGED_IN_ACCOUNT)
        }
    }
    
    static func loggedInAccount() -> Account? {
        let accountData = UserDefaults.standard.object(forKey: Account.LOGGED_IN_ACCOUNT) as? Data
        if let accountSaved = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(accountData!) {
            return accountSaved as? Account
        }
        
        return nil
    }
    
    static func loggedInAccessToken() -> String {
        if let loggedInAccount = Account.loggedInAccount() {
            return "Bearer \(loggedInAccount.accessToken)"
        }
        
        return ""
    }
    
}

