//
//  MainNavigator.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

import UIKit

protocol MainNavigatorType {
    
}

struct MainNavigator: MainNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
