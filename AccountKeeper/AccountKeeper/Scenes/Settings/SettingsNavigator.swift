//
//  SettingsNavigator.swift
//  AccountKeeper
//
//  Created by NamTrinh on 26/06/2023.
//

import UIKit

protocol SettingsNavigatorType {
    func dissmiss()
    func toCreatePasscode()
    func toChangePasscode()
}

struct SettingsNavigator: SettingsNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func dissmiss() {
        navigationController.dismiss(animated: true)
    }
    
    func toCreatePasscode() {
        let vc: PasscodeViewController = assembler.resolve(navigationController: navigationController, mode: .new)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toChangePasscode() {
        let vc: PasscodeViewController = assembler.resolve(navigationController: navigationController, mode: .change)
        navigationController.pushViewController(vc, animated: true)
    }
}
