//
//  AppDelegate.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var assembler: Assembler = DefaultAssembler()
    var disposeBag = DisposeBag()

    func applicationDidFinishLaunching(_ application: UIApplication) {
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
        blurEffectView.tag = 1
        self.window?.addSubview(blurEffectView)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.window?.viewWithTag(1)?.removeFromSuperview()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        presentPasscode()
    }
    
    private func presentPasscode() {
        let passcodeVC: PasscodeViewController = assembler.resolve(navigationController: UINavigationController(),
                                                                   mode: .verify)
        WindowManager.shared.rootViewController = passcodeVC
        WindowManager.shared.isHidden = false
    }
}
