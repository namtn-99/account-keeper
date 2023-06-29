//
//  PasscodeNavigator.swift
//  AccountKeeper
//
//  Created by NamTrinh on 17/06/2023.
//

import UIKit

protocol PasscodeNavigatorType {
    func toMain()
    func dismiss()
    func toConfirmNew(previousPassCode: String)
    func toConfirmChange(previousPassCode: String)
    func popToRootViewController()
}

struct PasscodeNavigator: PasscodeNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMain() {
        let nav = UINavigationController()
        let vc: MainViewController = assembler.resolve(navigationController: nav)
        nav.viewControllers.append(vc)
        Utils.swapRootViewController(nav)
    }
    
    func dismiss() {
        WindowManager.shared.rootViewController = nil
        WindowManager.shared.isHidden = true
    }
    
    func toConfirmNew(previousPassCode: String) {
        let vc: PasscodeViewController = assembler.resolve(navigationController: navigationController, mode: .confirmNew, previousPasscode: previousPassCode)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toConfirmChange(previousPassCode: String) {
        let vc: PasscodeViewController = assembler.resolve(navigationController: navigationController, mode: .confirmChange, previousPasscode: previousPassCode)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popToRootViewController() {
        navigationController.popToRootViewController(animated: true)
    }
}
