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

enum PasscodeMode {
    case new
    case change
    case verify
    case confirm
    case unlock
}

final class PasscodeViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet private var inputViews: [UIView]!
    
    // MARK: - Properties
    
    var viewModel: PasscodeViewModel!
    var disposeBag = DisposeBag()
    
    var passcode = ""
    
    private let passcodeTrigger = PublishSubject<String>()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    @IBAction func handleNumberButton(_ sender: UIButton) {
        clearInput()
        passcode += sender.titleLabel?.text ?? ""
        if passcode.count == Constants.maxLengthPasscode {
            passcodeTrigger.onNext(passcode)
            return
        }
        for i in 0 ..< passcode.count {
            inputViews[i].backgroundColor = UIColor.init(hexString: "#526D82")
        }
        
        print(passcode)
    }
    
    @IBAction func handleDeleteButton(_ sender: UIButton) {
        if !passcode.isEmpty {
            clearInput()
            passcode.removeLast()
            for i in 0 ..< passcode.count {
                inputViews[i].backgroundColor = UIColor.init(hexString: "#526D82")
            }
        }
    }
    
    private func configView() {
        
    }
    
    private func clearInput() {
        inputViews.forEach { $0.backgroundColor = UIColor.init(hexString: "#D9D9D9") }
    }
    
    func bindViewModel() {
        let input = PasscodeViewModel.Input(passcodeTrigger: passcodeTrigger.asDriverOnErrorJustComplete())
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
