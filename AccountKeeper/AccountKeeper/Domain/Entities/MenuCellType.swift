//
//  MenuCellType.swift
//  AccountKeeper
//
//  Created by NamTrinh on 26/06/2023.
//

import UIKit

struct MenuCellData {
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
    case accountType
    
    func getCellData() -> MenuCellData {
        switch self {
        case .settings:
            return MenuCellData(icon: Asset.icSettings.image, title: L10n.Menu.settings, mode: .info)
        case .support:
            return MenuCellData(icon: Asset.icSupport.image, title: L10n.Menu.support, mode: .info)
        case .accountType:
            return MenuCellData(icon: UIImage(systemName: "person.2.circle"), title: "Account Type", mode: .info)
        }
    }
}
