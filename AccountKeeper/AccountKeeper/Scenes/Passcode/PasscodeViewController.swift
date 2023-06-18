//
//  PasscodeViewController.swift
//  AccountKeeper
//
//  Created by NamTrinh on 17/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Then

final class PasscodeViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var toMainButton: UIButton!
    
    // MARK: - Properties
    
    var viewModel: PasscodeViewModel!
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        
    }
    
    func bindViewModel() {
        let input = PasscodeViewModel.Input(toMain: toMainButton.rx.tap.asDriver())
        let output = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Binders
extension PasscodeViewController {
    
}

// MARK: - StoryboardSceneBased
extension PasscodeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.passcode
}
