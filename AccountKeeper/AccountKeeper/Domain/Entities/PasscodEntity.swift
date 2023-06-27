//
//  PasscodEntity.swift
//  AccountKeeper
//
//  Created by NamTrinh on 27/06/2023.
//

import Foundation

struct PasscodeEntity: Codable {
    var passcode: String
    var incorrectCount: Int
    
    init() {
        passcode = ""
        incorrectCount = 0
    }
    
    init(passcode: String) {
        self.passcode = passcode
        incorrectCount = 0
    }
}
