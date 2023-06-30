//
//  PasscodeViewModel.swift
//  AccountKeeper
//
//  Created by NamTrinh on 17/06/2023.
//

import RxSwift
import RxCocoa
import LocalAuthentication

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
        let loadTrigger: Driver<Void>
        let unlockWithBiometric: Driver<Void>
    }
    
    struct Output {
        let error: Driver<PasscodeError?>
        let isEnableBiometric: Driver<Bool>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let errorSubject = BehaviorSubject<PasscodeError?>(value: nil)
        let isEnableBiometricSubject = PublishSubject<Bool>()
        
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
        
        input.loadTrigger
            .drive(onNext: { _ in
                let isOn = LAContext().isPremissionBiometric && (AppSettings.passcodeEnableFaceId || AppSettings.passcodeEnableTouchId)
                isEnableBiometricSubject.onNext(isOn)
                if !LAContext().isPremissionBiometric {
                    AppSettings.passcodeEnableFaceId = false
                    AppSettings.passcodeEnableTouchId = false
                }
            })
            .disposed(by: disposeBag)
        
        input.unlockWithBiometric
            .drive(onNext: { _ in
                switch mode {
                case .unlock:
                    navigator.toMain()
                case .verify:
                    navigator.dismiss()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            error: errorSubject.asDriverOnErrorJustComplete(),
            isEnableBiometric: isEnableBiometricSubject.asDriverOnErrorJustComplete()
        )
    }
}
