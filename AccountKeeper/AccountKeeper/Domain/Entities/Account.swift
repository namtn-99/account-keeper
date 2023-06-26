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
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var username: String
    @Persisted var password: String
    @Persisted var qrCode: String?
    var accountType: AccountType
    
    init(_id: String, username: String, password: String, qrCode: String? = nil, accountType: AccountType) {
        self.username = username
        self.password = password
        self.qrCode = qrCode
        self.accountType = accountType
    }
}

class AccountType: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var name: String
    @Persisted var image: String
}
