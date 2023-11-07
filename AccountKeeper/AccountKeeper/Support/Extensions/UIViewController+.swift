//
//  UIViewController+.swift
//  AccountKeeper
//
//  Created by NamTrinh on 17/06/2023.
//

import UIKit

extension UIViewController {
    func logDeinit() {
        print(String(describing: type(of: self)) + " deinit")
    }
    
    func showNavigateToSettings(title: String = L10n.Settings.Popup.goToSettings,
                                message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: L10n.Settings.Popup.settings, style: .cancel) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: L10n.Settings.Popup.cancel, style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
