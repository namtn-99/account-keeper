//
//  Constants.swift
//  AccountKeeper
//
//  Created by NamTrinh on 25/06/2023.
//

import UIKit

enum Constants {
    static let maxLengthPasscode = 6
    static let defaultLogoHeight: CGFloat = 55
    static let largeLogoHeight: CGFloat = 100
    static let widthMenuView = UIScreen.main.bounds.width * 2 / 3
    static let selectionPopoverSize: CGSize = CGSize(width: 200, height: 100)
    
    enum WindowLevel {
        static let appVersionUpdatePopup: UIWindow.Level = .normal + 4
        static let passcodeView: UIWindow.Level = .normal + 1
    }
}
