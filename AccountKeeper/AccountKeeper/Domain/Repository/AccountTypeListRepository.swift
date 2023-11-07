//
//  AccountTypeListRepository.swift
//  AccountKeeper
//
//  Created by NamTrinh on 17/08/2023.
//

import Foundation
import RxSwift

protocol AccountTypeListRepositoryType {
    func getAccountType() -> Observable<[AccountType]>
}

struct AccountTypeListRepositoryImpl: AccountTypeListRepositoryType {
    let realmService = RealmService.shared
    
    func getAccountType() -> Observable<[AccountType]> {
        return Observable.create { observer in
            let result = realmService.fetchAll(AccountType.self)
            observer.onNext(result.toArray(ofType: AccountType.self))
            return Disposables.create()
        }
    }
}
