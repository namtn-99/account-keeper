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
        bindViewModel()
    }
    
    private func bindViewModel() {
        let vm: AppViewModel = assembler.resolve(window: window!)
        let input = AppViewModel.Input(load: Driver.just(()))
        _ = vm.transform(input, disposeBag: disposeBag)
    }
}

