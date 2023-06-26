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
    let screenType: PasscodeMode = .unlock
}

// MARK: - ViewModel
extension PasscodeViewModel: ViewModel {
    struct Input {
        let passcodeTrigger: Driver<String>
    }
    
    struct Output {
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        input.passcodeTrigger
            .drive(onNext: { passcode in
                self.navigator.toMain()
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
}
