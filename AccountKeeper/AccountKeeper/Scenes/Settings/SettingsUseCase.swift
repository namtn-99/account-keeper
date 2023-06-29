//
//  SettingsUseCase.swift
//  AccountKeeper
//
//  Created by NamTrinh on 26/06/2023.
//

import RxSwift

protocol SettingsUseCaseType {
    func turnPasscodeOff()
    func unlockWithFaceId(isOn: Bool)
    func unlockWithTouchId(isOn: Bool)
}

struct SettingsUseCase: SettingsUseCaseType {
    func turnPasscodeOff() {
        AppSettings.passcodeEntity = nil
        AppSettings.passcodeEnableTouchId = false
        AppSettings.passcodeEnableFaceId = false
    }
    
    func unlockWithFaceId(isOn: Bool) {
        AppSettings.passcodeEnableFaceId = isOn
    }
    
    func unlockWithTouchId(isOn: Bool) {
        AppSettings.passcodeEnableTouchId = isOn
    }
}
