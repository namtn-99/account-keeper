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
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
