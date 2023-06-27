//
//  MenuCellType.swift
//  AccountKeeper
//
//  Created by NamTrinh on 26/06/2023.
//

import UIKit

struct SettingCellData {
    enum CellMode {
        case disclosure
        case `switch`
        case info
        case action(UIColor)
    }

    let icon: UIImage?
    let title: String
    let mode: CellMode
}

enum MenuCellType {
    case support
    case settings
    
    func getCellData() -> SettingCellData {
        switch self {
        case .settings:
            return SettingCellData(icon: Asset.icSettings.image, title: L10n.Menu.settings, mode: .info)
        case .support:
            return SettingCellData(icon: Asset.icSupport.image, title: L10n.Menu.support, mode: .info)
        }
    }
}
