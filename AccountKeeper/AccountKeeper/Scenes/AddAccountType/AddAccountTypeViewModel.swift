//
//  AddAccountTypeViewModel.swift
//  AccountKeeper
//
//  Created by NamTrinh on 06/07/2023.
//

import RxSwift
import RxCocoa

enum ChangeAccountType {
    case edit
    case add
}

struct AddAccountTypeViewModel {
    let type: ChangeAccountType
    let navigator: AddAccountTypeNavigatorType
    let useCase: AddAccountTypeUseCaseType
}

// MARK: - ViewModel
extension AddAccountTypeViewModel: ViewModel {
    struct Input {
        let backTrigger: Driver<Void>
        let name: Driver<String>
        let icon: Driver<UIImage?>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()

        input.backTrigger
            .drive(onNext: navigator.back)
            .disposed(by: disposeBag)
        
        return output
    }
}
