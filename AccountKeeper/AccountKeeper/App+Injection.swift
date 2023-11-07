//
//  App+Injection.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/08/2023.
//

import Foundation

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerDomain()
        registerData()
    }
}
