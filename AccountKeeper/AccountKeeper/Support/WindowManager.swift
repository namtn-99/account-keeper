//
//  WindowManager.swift
//  AccountKeeper
//
//  Created by NamTrinh on 30/06/2023.
//

import UIKit

enum WindowManager {
    static let shared: UIWindow = {
        let wd = UIWindow(frame: UIScreen.main.bounds)
        wd.isHidden = true
        wd.windowLevel = Constants.WindowLevel.passcodeView
        wd.rootViewController = UIViewController()
        return wd
    }()
}

