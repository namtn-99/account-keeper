//
//  AppDelegate.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var assembler: Assembler = DefaultAssembler()
    var disposeBag = DisposeBag()

    func applicationDidFinishLaunching(_ application: UIApplication) {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        bindViewModel(window: window)
    }
    
    private func bindViewModel(window: UIWindow) {
        let vm: AppViewModel = assembler.resolve(window: window)
        let input = AppViewModel.Input(load: Driver.just(()))
        _ = vm.transform(input, disposeBag: disposeBag)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = window!.frame
        blurEffectView.tag = 11
        self.window?.addSubview(blurEffectView)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.window?.viewWithTag(11)?.removeFromSuperview()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if AppSettings.passcodeEntity != nil {
            presentPasscode()
        }
    }
    
    private func presentPasscode() {
        let passcodeVC: PasscodeViewController = assembler.resolve(navigationController: UINavigationController(),
                                                                   mode: .verify)
        if WindowManager.shared.rootViewController != nil {
            WindowManager.shared.rootViewController = nil
        }
        WindowManager.shared.rootViewController = passcodeVC
        WindowManager.shared.isHidden = false
    }
}
