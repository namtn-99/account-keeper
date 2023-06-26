//
//  AddAccountNavigator.swift
//  AccountKeeper
//
//  Created by NamTrinh on 25/06/2023.
//

import UIKit

protocol AddAccountNavigatorType {
    
}

struct AddAccountNavigator: AddAccountNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
