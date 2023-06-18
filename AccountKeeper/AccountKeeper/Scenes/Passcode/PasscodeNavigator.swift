//
//  PasscodeNavigator.swift
//  AccountKeeper
//
//  Created by NamTrinh on 17/06/2023.
//

import UIKit

protocol PasscodeNavigatorType {
    func toMain()
}

struct PasscodeNavigator: PasscodeNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMain() {
        let nav = UINavigationController()
        let vc: MainViewController = assembler.resolve(navigationController: nav)
        nav.viewControllers.append(vc)
        Utils.swapRootViewController(vc)
    }
}
