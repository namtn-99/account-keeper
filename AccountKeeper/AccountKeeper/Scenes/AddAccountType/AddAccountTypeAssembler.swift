//
//  AddAccountTypeAssembler.swift
//  AccountKeeper
//
//  Created by NamTrinh on 06/07/2023.
//

import UIKit
import Reusable

protocol AddAccountTypeAssembler {
    func resolve(type: ChangeAccountType,
                        navigationController: UINavigationController) -> AddAccountTypeViewController
    func resolve(type: ChangeAccountType,
                        navigationController: UINavigationController) -> AddAccountTypeViewModel
    func resolve(navigationController: UINavigationController) -> AddAccountTypeNavigatorType
    func resolve() -> AddAccountTypeUseCaseType
}

extension AddAccountTypeAssembler {
    func resolve(type: ChangeAccountType, navigationController: UINavigationController) -> AddAccountTypeViewController {
        let vc = AddAccountTypeViewController.instantiate()
        let vm: AddAccountTypeViewModel = resolve(type: type, navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(type: ChangeAccountType, navigationController: UINavigationController) -> AddAccountTypeViewModel {
        return AddAccountTypeViewModel(
            type: type,
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension AddAccountTypeAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> AddAccountTypeNavigatorType {
        return AddAccountTypeNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> AddAccountTypeUseCaseType {
        return AddAccountTypeUseCase()
    }
}
