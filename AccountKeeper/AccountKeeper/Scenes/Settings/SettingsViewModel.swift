//
//  SettingsViewModel.swift
//  AccountKeeper
//
//  Created by NamTrinh on 26/06/2023.
//

import RxSwift
import RxCocoa

struct SettingsViewModel {
    let navigator: SettingsNavigatorType
    let useCase: SettingsUseCaseType
}

// MARK: - ViewModel
extension SettingsViewModel: ViewModel {
    struct Input {
        let dissmissTrigger: Driver<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        input.dissmissTrigger
            .drive(onNext: self.navigator.dissmiss)
            .disposed(by: disposeBag)
        
        return Output()
    }
}
