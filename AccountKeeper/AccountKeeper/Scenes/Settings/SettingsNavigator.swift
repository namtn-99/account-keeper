//
//  SettingsNavigator.swift
//  AccountKeeper
//
//  Created by NamTrinh on 26/06/2023.
//

import UIKit

protocol SettingsNavigatorType {
    func dissmiss()
}

struct SettingsNavigator: SettingsNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func dissmiss() {
        navigationController.dismiss(animated: true)
    }
}
