//
//  Domain+Injection.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/08/2023.
//

import Foundation

extension Resolver {
    static func registerDomain() {
        register { SettingsUseCase() as SettingsUseCaseType }
        register { AddAccountTypeUseCase() as AddAccountTypeUseCaseType }
        register { AccountTypeListUseCase() as AccountTypeListUseCaseType }
    }
}
