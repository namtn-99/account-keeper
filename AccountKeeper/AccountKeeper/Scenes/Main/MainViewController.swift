//
//  MainViewController.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Then

final class MainViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var viewModel: MainViewModel!
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    
    // MARK: - Methods
    
    private func configView() {
        navigationController?.navigationBar.isHidden = false
    }
    
    func bindViewModel() {
        let input = MainViewModel.Input()
        let output = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Binders
extension MainViewController {
    
}

// MARK: - StoryboardSceneBased
extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
