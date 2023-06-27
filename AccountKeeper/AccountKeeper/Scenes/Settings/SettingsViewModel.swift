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
    let useCase: SettingsUseCaseType
}

// MARK: - ViewModel
extension SettingsViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
        let dissmissTrigger: Driver<Void>
    }
    
    struct Output {
        let settingsSections: Driver<[SettingsSection]>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let settingsSections = BehaviorSubject<[SettingsSection]>(value: [])
        
        input.dissmissTrigger
            .drive(onNext: self.navigator.dissmiss)
            .disposed(by: disposeBag)
        
        input.loadTrigger
            .drive(onNext: { _ in
                let section = self.getSettingSections()
                settingsSections.onNext(section)
            })
            .disposed(by: disposeBag)
        
        return Output(settingsSections: settingsSections.asDriverOnErrorJustComplete())
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
                securityCells.append(.unlockWithFaceId(AppSettings.passcodeEnableTouchId))
            default:
                break
            }
        }
        
        return [SettingsSection(type: .security, cells: securityCells)]
    }
}
