//
//  AppViewModel.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

import RxSwift
import RxCocoa

struct AppViewModel {
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

// MARK: - ViewModel
extension AppViewModel: ViewModel {
    struct Input {
        let load: Driver<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        input.load
            .drive(onNext: { _ in
                if AppSettings.passcodeEntity != nil {
                    self.navigator.toPasscode()
                } else {
                    self.navigator.toMain()
                }
            })
            .disposed(by: disposeBag)

        return Output()
    }
}
