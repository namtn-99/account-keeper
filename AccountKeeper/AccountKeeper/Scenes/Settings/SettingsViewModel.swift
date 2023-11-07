//
//  SettingsViewModel.swift
//  AccountKeeper
//
//  Created by NamTrinh on 26/06/2023.
//

import RxSwift
import RxCocoa
import LocalAuthentication

struct SettingsViewModel {
    let navigator: SettingsNavigatorType
    @Injected var useCase: SettingsUseCaseType
}

// MARK: - ViewModel
extension SettingsViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
        let dissmissTrigger: Driver<Void>
        let actionTrigger: Driver<SettingsCellType>
        let turnOffPasscode: Driver<Void>
        let biometricSettings: Driver<Bool>
    }
    
    struct Output {
        let settingsSections: Driver<[SettingsSection]>
        let confirmTurnOffPasscode: Driver<Void>
        let reload: Driver<Void>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let settingsSections = BehaviorSubject<[SettingsSection]>(value: [])
        let confirmTurnOffPasscode = PublishSubject<Void>()
        let reloadSubject = PublishSubject<Void>()
        
        input.dissmissTrigger
            .drive(onNext: self.navigator.dissmiss)
            .disposed(by: disposeBag)
        
        input.loadTrigger
            .drive(onNext: { _ in
                let section = self.getSettingSections()
                settingsSections.onNext(section)
            })
            .disposed(by: disposeBag)
        
        input.actionTrigger
            .drive(onNext: { settingsCellType in
                switch settingsCellType {
                case .turnPasscodeOn:
                    self.navigator.toCreatePasscode()
                case  .turnPasscodeOff:
                    confirmTurnOffPasscode.onNext(())
                case .unlockWithFaceId(let isOn):
                    self.useCase.unlockWithFaceId(isOn: isOn)
                case .unlockWithTouchId(let isOn):
                    self.useCase.unlockWithTouchId(isOn: isOn)
                case .changePasscode:
                    self.navigator.toChangePasscode()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        input.turnOffPasscode
            .drive(onNext: {
                self.useCase.turnPasscodeOff()
                reloadSubject.onNext(())
            })
            .disposed(by: disposeBag)
        
        input.biometricSettings
            .drive(onNext: { isOn in
                switch LAContext().biometricType {
                case .faceID:
                    useCase.unlockWithFaceId(isOn: isOn)
                case .touchID:
                    useCase.unlockWithTouchId(isOn: isOn)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            settingsSections: settingsSections.asDriverOnErrorJustComplete(),
            confirmTurnOffPasscode: confirmTurnOffPasscode.asDriverOnErrorJustComplete(),
            reload: reloadSubject.asDriverOnErrorJustComplete()
        )
    }
}

extension SettingsViewModel {
    private func getSettingSections() -> [SettingsSection] {
        var securityCells: [SettingsCellType] = []
        if AppSettings.passcodeEntity == nil {
            securityCells.append(.turnPasscodeOn)
        } else {
            securityCells.append(.turnPasscodeOff)
            securityCells.append(.changePasscode)
            
            switch LAContext().biometricType {
            case .faceID:
                securityCells.append(.unlockWithFaceId(AppSettings.passcodeEnableFaceId))
            case .touchID:
                securityCells.append(.unlockWithTouchId(AppSettings.passcodeEnableTouchId))
            default:
                break
            }
        }
        return [SettingsSection(type: .security, cells: securityCells)]
    }
}
