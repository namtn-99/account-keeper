//
//  AppNavigator.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

import UIKit

protocol AppNavigatorType {
    func toMain()
    func toPasscode()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toMain() {
        let nav = UINavigationController()
        let vc: MainViewController = assembler.resolve(navigationController: nav)
        nav.viewControllers.append(vc)
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
    func toPasscode() {
        let nav = UINavigationController()
        let vc: PasscodeViewController = assembler.resolve(navigationController: nav, mode: .unlock)
        nav.viewControllers.append(vc)
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
