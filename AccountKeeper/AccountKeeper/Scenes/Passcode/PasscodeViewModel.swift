//
//  PasscodeViewModel.swift
//  AccountKeeper
//
//  Created by NamTrinh on 17/06/2023.
//

import RxSwift
import RxCocoa

struct PasscodeViewModel {
    let navigator: PasscodeNavigatorType
    let useCase: PasscodeUseCaseType
}

// MARK: - ViewModel
extension PasscodeViewModel: ViewModel {
    struct Input {
        let toMain: Driver<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        input.toMain
            .drive(onNext: self.navigator.toMain)
            .disposed(by: disposeBag)
        
        return Output()
    }
}
