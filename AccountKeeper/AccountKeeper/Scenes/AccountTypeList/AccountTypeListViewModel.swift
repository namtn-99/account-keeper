//
//  AccountTypeListViewModel.swift
//  AccountKeeper
//
//  Created by NamTrinh on 13/08/2023.
//

import RxSwift
import RxCocoa

struct AccountTypeListViewModel {
    let navigator: AccountTypeListNavigatorType
    @Injected var useCase: AccountTypeListUseCaseType
}

// MARK: - ViewModel
extension AccountTypeListViewModel: ViewModel {
    struct Input {
        let load: Driver<Void>
        let dismiss: Driver<Void>
        let edit: Driver<AccountType>
        let delete: Driver<AccountType>
        let add: Driver<Void>
    }
    
    struct Output {
        @Property var accountType = [AccountType]()
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.load
            .flatMapLatest { _ in
                useCase.getAccountType()
                    .asDriverOnErrorJustComplete()
            }
            .drive(output.$accountType)
            .disposed(by: disposeBag)
        
        input.dismiss
            .drive(onNext: navigator.dismiss)
            .disposed(by: disposeBag)
        
        input.edit
            .drive(onNext: navigator.toEditAccountType(_:))
            .disposed(by: disposeBag)
        
        input.add
            .drive(onNext: navigator.toAddAccountType)
            .disposed(by: disposeBag)
        
        return output
    }
}
