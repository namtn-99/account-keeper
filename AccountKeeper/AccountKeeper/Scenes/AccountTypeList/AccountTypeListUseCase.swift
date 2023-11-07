//
//  AccountTypeListUseCase.swift
//  AccountKeeper
//
//  Created by NamTrinh on 13/08/2023.
//

import RxSwift

protocol AccountTypeListUseCaseType {
    func getAccountType() -> Observable<[AccountType]>
}

struct AccountTypeListUseCase: AccountTypeListUseCaseType {
    @Injected var repository: AccountTypeListRepositoryType
    
    func getAccountType() -> Observable<[AccountType]> {
        repository.getAccountType()
    }
}
