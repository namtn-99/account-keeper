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
            .drive(onNext: self.navigator.toPasscode)
            .disposed(by: disposeBag)

        return Output()
    }
}
