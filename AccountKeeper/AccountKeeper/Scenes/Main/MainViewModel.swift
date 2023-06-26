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
    }
    
    struct Output {
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let toAddAccount = input.toAddAccountTrigger
            .drive(onNext: self.navigator.toAddAccount)
            .disposed(by: disposeBag)
        return Output()
    }
}
