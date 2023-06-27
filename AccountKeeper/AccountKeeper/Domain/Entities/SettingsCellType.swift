//
//  SettingsCellType.swift
//  AccountKeeper
//
//  Created by NamTrinh on 27/06/2023.
//

import UIKit
import LocalAuthentication

struct SettingsSection {
    let type: SettingsSectionType
    let cells: [SettingsCellType]
}

enum SettingsSectionType {
    case security
    
    var title: String {
        switch self {
        case .security:
            return L10n.Settings.security
        }
    }
}

struct SettingsCellData {
    enum CellMode {
        case disclosure
        case `switch`(Bool)
        case info
        case action(UIColor)
    }

    let icon: UIImage?
    let title: String
    let mode: CellMode
}

enum SettingsCellType {
    case turnPasscodeOn
    case turnPasscodeOff
    case changePasscode
    case unlockWithFaceId(Bool)
    case unlockWithTouchId(Bool)
    case autoLock
    
    func getCellData() -> SettingsCellData {
        switch self {
        case .turnPasscodeOn:
            return SettingsCellData(icon: Asset.icSecurity.image, title: L10n.Settings.TurnPasscode.on, mode: .disclosure)
        case .turnPasscodeOff:
            return SettingsCellData(icon: nil, title: L10n.Settings.TurnPasscode.off, mode: .disclosure)
        case .changePasscode:
            return SettingsCellData(icon: nil, title: L10n.Settings.changePasscode, mode: .disclosure)
        case .unlockWithFaceId(let isOn):
            return SettingsCellData(icon: Asset.icFaceID.image, title: L10n.Settings.faceId, mode: .switch(isOn))
        case .unlockWithTouchId(let isOn):
            return SettingsCellData(icon: Asset.icTouchID.image, title: L10n.Settings.touchId, mode: .switch(isOn))
        case .autoLock:
            return SettingsCellData(icon: nil, title: "Auto Lock", mode: .info)
        }
    }
}
