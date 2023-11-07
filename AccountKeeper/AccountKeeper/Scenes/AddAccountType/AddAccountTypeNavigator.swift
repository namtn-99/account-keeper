//
//  AddAccountTypeNavigator.swift
//  AccountKeeper
//
//  Created by NamTrinh on 06/07/2023.
//

import UIKit

protocol AddAccountTypeNavigatorType {
    func back()
}

struct AddAccountTypeNavigator: AddAccountTypeNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
