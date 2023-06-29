//
//  PasscodeUseCase.swift
//  AccountKeeper
//
//  Created by NamTrinh on 17/06/2023.
//

import RxSwift

protocol PasscodeUseCaseType {
    func savePasscode(passcode: String)
    func updatePasscode(passcode: String)
    func verifyPasscode(passcode: String) -> Bool
}

struct PasscodeUseCase: PasscodeUseCaseType {
    func savePasscode(passcode: String) {
        AppSettings.passcodeEntity = PasscodeEntity(passcode: passcode)
    }
    
    func updatePasscode(passcode: String) {
        AppSettings.passcodeEntity = PasscodeEntity(passcode: passcode)
    }
    
    func verifyPasscode(passcode: String) -> Bool {
        return AppSettings.passcodeEntity?.passcode == passcode
    }
}
