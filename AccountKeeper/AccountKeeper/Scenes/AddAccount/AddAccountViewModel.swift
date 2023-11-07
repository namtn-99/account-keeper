//
//  AddAccountViewModel.swift
//  AccountKeeper
//
//  Created by NamTrinh on 25/06/2023.
//

import RxSwift
import RxCocoa

struct AddAccountViewModel {
    let navigator: AddAccountNavigatorType
    let useCase: AddAccountUseCaseType
}

// MARK: - ViewModel
extension AddAccountViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        input.loadTrigger
            .drive(onNext: { _ in
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
}
