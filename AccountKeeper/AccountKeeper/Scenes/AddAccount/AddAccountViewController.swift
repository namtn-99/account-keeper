//
//  AddAccountViewController.swift
//  AccountKeeper
//
//  Created by NamTrinh on 25/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Then

final class AddAccountViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var viewModel: AddAccountViewModel!
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        
    }
    
    func bindViewModel() {
        let input = AddAccountViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Binders
extension AddAccountViewController {
    
}

// MARK: - StoryboardSceneBased
extension AddAccountViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.addAccount
}
