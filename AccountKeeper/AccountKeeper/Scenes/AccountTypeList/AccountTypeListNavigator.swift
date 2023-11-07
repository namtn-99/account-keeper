//
//  AccountTypeListNavigator.swift
//  AccountKeeper
//
//  Created by NamTrinh on 13/08/2023.
//

import UIKit

protocol AccountTypeListNavigatorType {
    func dismiss()
    func toEditAccountType(_ accountType: AccountType)
    func toAddAccountType()
}

struct AccountTypeListNavigator: AccountTypeListNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    func toEditAccountType(_ accountType: AccountType) {
        let vc: AddAccountTypeViewController = assembler.resolve(type: .edit, navigationController: navigationController)
        vc.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toAddAccountType() {
        let vc: AddAccountTypeViewController = assembler.resolve(type: .add, navigationController: navigationController)
        vc.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(vc, animated: true)
    }

}
