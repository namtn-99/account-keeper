//
//  SettingsAssembler.swift
//  AccountKeeper
//
//  Created by NamTrinh on 26/06/2023.
//

import UIKit
import Reusable

protocol SettingsAssembler {
    func resolve(navigationController: UINavigationController) -> SettingsViewController
    func resolve(navigationController: UINavigationController) -> SettingsViewModel
    func resolve(navigationController: UINavigationController) -> SettingsNavigatorType
    func resolve() -> SettingsUseCaseType
}

extension SettingsAssembler {
    func resolve(navigationController: UINavigationController) -> SettingsViewController {
        let vc = SettingsViewController.instantiate()
        let vm: SettingsViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> SettingsViewModel {
        return SettingsViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension SettingsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SettingsNavigatorType {
        return SettingsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> SettingsUseCaseType {
        return SettingsUseCase()
    }
}
