//
//  Data+Injection.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/08/2023.
//

import Foundation

extension Resolver {
    static func registerData() {
        register { AccountTypeListRepositoryImpl() as AccountTypeListRepositoryType}
    }
}
