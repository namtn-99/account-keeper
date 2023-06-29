//
//  MainNavigator.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

import UIKit

protocol MainNavigatorType {
    func toAddAccount()
    func toSettings()
}

struct MainNavigator: MainNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toAddAccount() {
        let vc: AddAccountViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toSettings() {
        let nav = UINavigationController()
        let vc: SettingsViewController = assembler.resolve(navigationController: nav)
        nav.viewControllers.append(vc)
        nav.modalPresentationStyle = .fullScreen
        navigationController.viewControllers.first?.present(nav, animated: true)
    }
}
