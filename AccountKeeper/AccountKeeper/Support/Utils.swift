//
//  Utils.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

import UIKit

enum Utils {
    static func after(interval: TimeInterval, completion: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion?()
        }
    }
    
    static func swapRootViewController(_ newRootViewController: UIViewController,
                                       duration: TimeInterval = 0.3,
                                       completion: (() -> Void)? = nil) {
        guard let window = UIApplication.keyWindow() else {
            return
        }
        window.rootViewController = newRootViewController
        UIView.transition(with: window, duration: duration) {
            completion?()
        }
    }
}
