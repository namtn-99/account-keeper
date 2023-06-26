//
//  AddAccountAssembler.swift
//  AccountKeeper
//
//  Created by NamTrinh on 25/06/2023.
//

import UIKit
import Reusable

protocol AddAccountAssembler {
    func resolve(navigationController: UINavigationController) -> AddAccountViewController
    func resolve(navigationController: UINavigationController) -> AddAccountViewModel
    func resolve(navigationController: UINavigationController) -> AddAccountNavigatorType
    func resolve() -> AddAccountUseCaseType
}

extension AddAccountAssembler {
    func resolve(navigationController: UINavigationController) -> AddAccountViewController {
        let vc = AddAccountViewController.instantiate()
        let vm: AddAccountViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> AddAccountViewModel {
        return AddAccountViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension AddAccountAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> AddAccountNavigatorType {
        return AddAccountNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> AddAccountUseCaseType {
        return AddAccountUseCase()
    }
}
