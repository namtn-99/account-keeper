//
//  ViewModel.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

import Foundation
import RxSwift

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output
}

public protocol Bindable: AnyObject {
    associatedtype ViewModel
    
    var viewModel: ViewModel! { get set }
    
    func bindViewModel()
}

extension Bindable where Self: UIViewController {
    public func bindViewModel(to model: Self.ViewModel) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
