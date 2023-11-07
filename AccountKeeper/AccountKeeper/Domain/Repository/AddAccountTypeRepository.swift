//
//  AddAccountTypeRepository.swift
//  AccountKeeper
//
//  Created by NamTrinh on 22/07/2023.
//

import Foundation
import RxSwift

protocol AddAccountRepositoryType {
    func getAccountType(by name: String) -> Observable<AccountType?>
    func saveAccountType(name: String, iconUri: String)
}

struct AddAccountRepositoryImpl: AddAccountRepositoryType {
    let realmService = RealmService.shared
    
    func getAccountType(by name: String) -> Observable<AccountType?> {
        return Observable.create { observer in
            let obj = realmService.fetchAll(AccountType.self).filter {
                $0.name == name
            }
            observer.onNext(obj.first)
            return Disposables.create()
        }
    }
    
    func saveAccountType(name: String, iconUri: String) {
//        let obj = AccountType(_id: String, name: <#T##String#>, image: <#T##String#>)
//        return Observable.create { observer in
//            let objc = realmService.insert(item: <#T##T#>)
//        }
    }
}
