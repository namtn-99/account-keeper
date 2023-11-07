//
//  SelectionPopoverViewController.swift
//  AccountKeeper
//
//  Created by NamTrinh on 02/07/2023.
//

import UIKit
import RxCocoa
import RxSwift
import Reusable

protocol SelectionPopoverViewControllerDelegate: AnyObject {
    func didSelectedNewAccount()
    func didSelectedNewTypeAccount()
}

final class SelectionPopoverViewController: UIViewController {
    @IBOutlet weak var newAccountButton: UIButton!
    @IBOutlet weak var newTypeAccountButton: UIButton!
    
    weak var delegate: SelectionPopoverViewControllerDelegate?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        view.layer.cornerRadius = 16
    }
    
    deinit {
        logDeinit()
    }
    
    private func setUpView() {
        newAccountButton.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: false)
                self?.delegate?.didSelectedNewAccount()
            })
            .disposed(by: disposeBag)
        
        newTypeAccountButton.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: false)
                self?.delegate?.didSelectedNewTypeAccount()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - StoryboardSceneBased
extension SelectionPopoverViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.selectionPopover
}
