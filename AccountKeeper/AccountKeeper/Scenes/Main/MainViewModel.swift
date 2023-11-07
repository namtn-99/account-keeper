//
//  MainViewModel.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

import RxSwift
import RxCocoa

struct MainViewModel {
    let navigator: MainNavigatorType
    let useCase: MainUseCaseType
}

// MARK: - ViewModel
extension MainViewModel: ViewModel {
    struct Input {
        let toAddAccountTrigger: Driver<Void>
        let toSettingsTrigger: Driver<Void>
        let toAccountTypeTrigger: Driver<Void>
    }
    
    struct Output {
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        input.toAddAccountTrigger
            .drive(onNext: self.navigator.toAddAccount)
            .disposed(by: disposeBag)
        
        input.toAccountTypeTrigger
            .drive(onNext: self.navigator.toAccountType)
            .disposed(by: disposeBag)
        
        input.toSettingsTrigger
            .drive(onNext: self.navigator.toSettings)
            .disposed(by: disposeBag)
        
        return Output()
    }
}
