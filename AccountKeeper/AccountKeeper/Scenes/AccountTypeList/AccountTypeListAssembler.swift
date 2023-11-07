//
//  AccountTypeListAssembler.swift
//  AccountKeeper
//
//  Created by NamTrinh on 13/08/2023.
//

import UIKit
import Reusable

protocol AccountTypeListAssembler {
    func resolve(navigationController: UINavigationController) -> AccountTypeListViewController
    func resolve(navigationController: UINavigationController) -> AccountTypeListViewModel
    func resolve(navigationController: UINavigationController) -> AccountTypeListNavigatorType
}

extension AccountTypeListAssembler {
    func resolve(navigationController: UINavigationController) -> AccountTypeListViewController {
        let vc = AccountTypeListViewController.instantiate()
        let vm: AccountTypeListViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> AccountTypeListViewModel {
        return AccountTypeListViewModel(
            navigator: resolve(navigationController: navigationController)
        )
    }
}

extension AccountTypeListAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> AccountTypeListNavigatorType {
        return AccountTypeListNavigator(assembler: self, navigationController: navigationController)
    }
}
