//
//  MainNavigator.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

import UIKit

protocol MainNavigatorType {
    func toAddAccount()
}

struct MainNavigator: MainNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toAddAccount() {
        let vc: AddAccountViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
}
