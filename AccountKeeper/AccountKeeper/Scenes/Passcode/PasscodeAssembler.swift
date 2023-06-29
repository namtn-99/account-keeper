//
//  PasscodeAssembler.swift
//  AccountKeeper
//
//  Created by NamTrinh on 17/06/2023.
//

import UIKit
import Reusable

protocol PasscodeAssembler {
    func resolve(navigationController: UINavigationController, mode: PasscodeMode, previousPasscode: String) -> PasscodeViewController
    func resolve(navigationController: UINavigationController, mode: PasscodeMode, previousPasscode: String) -> PasscodeViewModel
    func resolve(navigationController: UINavigationController) -> PasscodeNavigatorType
    func resolve() -> PasscodeUseCaseType
}

extension PasscodeAssembler {
    func resolve(navigationController: UINavigationController, mode: PasscodeMode, previousPasscode: String = "") -> PasscodeViewController {
        let vc = PasscodeViewController.instantiate()
        let vm: PasscodeViewModel = resolve(navigationController: navigationController,
                                            mode: mode,
                                            previousPasscode: previousPasscode)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController,
                 mode: PasscodeMode,
                 previousPasscode: String) -> PasscodeViewModel {
        return PasscodeViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            mode: mode,
            previousPasscode: previousPasscode
        )
    }
}

extension PasscodeAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> PasscodeNavigatorType {
        return PasscodeNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> PasscodeUseCaseType {
        return PasscodeUseCase()
    }
}
