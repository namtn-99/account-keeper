//
//  Account.swift
//  AccountKeeper
//
//  Created by NamTrinh on 18/06/2023.
//

import Foundation
import Security
import Realm
import RealmSwift

class Account: Object {
    @Persisted var username: String
    @Persisted var password: String
    @Persisted var qrCode: String?
    @Persisted var accountType: AccountType?
    
    convenience init(_id: String, username: String, password: String, qrCode: String? = nil, accountType: AccountType? = nil) {
        self.init()
        self.username = username
        self.password = password
        self.qrCode = qrCode
        self.accountType = accountType
    }
}

class AccountType: Object {
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var accounts = List<Account>()
    
    convenience init(_id: String, name: String, image: String) {
        self.init()
        self.name = name
        self.image = image
    }
}
