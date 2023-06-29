//
//  PasscodeViewModel.swift
//  AccountKeeper
//
//  Created by NamTrinh on 17/06/2023.
//

import RxSwift
import RxCocoa

enum PasscodeError: Error {
    case wrongPasscode
    case wrongConfirm
    
    var description: String {
        switch self {
        case .wrongPasscode:
            return L10n.Passcode.Error.wrong
        case .wrongConfirm:
            return L10n.Passcode.Error.Change.verify
        }
    }
}

struct PasscodeViewModel {
    let navigator: PasscodeNavigatorType
    let useCase: PasscodeUseCaseType
    let mode: PasscodeMode
    let previousPasscode: String
}

// MARK: - ViewModel
extension PasscodeViewModel: ViewModel {
    struct Input {
        let passcodeTrigger: Driver<String>
    }
    
    struct Output {
        let error: Driver<PasscodeError?>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let errorSubject = BehaviorSubject<PasscodeError?>(value: nil)
        
        input.passcodeTrigger
            .drive(onNext: { passcode in
                switch mode {
                case .unlock:
                    if useCase.verifyPasscode(passcode: passcode) {
                        navigator.toMain()
                    } else {
                        errorSubject.onNext(.wrongPasscode)
                    }
                case .new:
                    navigator.toConfirmNew(previousPassCode: passcode)
                case .change:
                    navigator.toConfirmChange(previousPassCode: passcode)
                case .verify:
                    if useCase.verifyPasscode(passcode: passcode) {
                        navigator.dismiss()
                    } else {
                        errorSubject.onNext(.wrongPasscode)
                    }
                case .confirmNew:
                    if passcode == previousPasscode {
                        useCase.savePasscode(passcode: passcode)
                        navigator.popToRootViewController()
                    } else {
                        errorSubject.onNext(.wrongConfirm)
                    }
                case .confirmChange:
                    if passcode == previousPasscode {
                        useCase.updatePasscode(passcode: passcode)
                        navigator.popToRootViewController()
                    } else {
                        errorSubject.onNext(.wrongConfirm)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        
        return Output(error: errorSubject.asDriverOnErrorJustComplete())
    }
}
