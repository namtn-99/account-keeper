//
//  AppSettings.swift
//  AccountKeeper
//
//  Created by NamTrinh on 18/06/2023.
//

import Foundation

enum AppSettings {
    @Storage(key: "passcodeEntity", defaultValue: nil)
    static var passcodeEntity: PasscodeEntity?
    
    @Storage(key: "passcodeEnableFaceId", defaultValue: false)
    static var passcodeEnableFaceId: Bool
    
    @Storage(key: "passcodeEnableTouchId", defaultValue: false)
    static var passcodeEnableTouchId: Bool
}
