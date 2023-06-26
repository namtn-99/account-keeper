//
//  AppSettings.swift
//  AccountKeeper
//
//  Created by NamTrinh on 18/06/2023.
//

import Foundation

enum AppSettings {
    @Storage(key: "passcodeEnable", defaultValue: false)
    static var passcodeEnable: Bool
}
