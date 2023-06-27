//
//  UIApplication+.swift
//  AccountKeeper
//
//  Created by NamTrinh on 17/06/2023.
//

import UIKit

extension UIApplication {
    static var share: UIApplication? = {
        return UIApplication.value(forKeyPath: #keyPath(UIApplication.shared)) as? UIApplication
    }()
    
    class func keyWindow() -> UIWindow? {
        if let sharedApplication = UIApplication.value(forKeyPath: #keyPath(UIApplication.shared)) as? UIApplication {
            return sharedApplication.windows.first(where: { $0.isKeyWindow }) ?? sharedApplication.windows.first
        }
        return nil
    }
}

extension Bundle {
    var releaseVersion: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildNumber: Int? {
        if let buildNumberString = infoDictionary?["CFBundleVersion"] as? String {
            return Int(buildNumberString)
        }
        return nil
    }

    var nameApp: String {
        return infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }
}
