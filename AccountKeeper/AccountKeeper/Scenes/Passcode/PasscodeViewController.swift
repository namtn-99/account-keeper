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
    case confirmChange
    case confirmNew
    case unlock
}

final class PasscodeViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var biometricButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var errorTitleLabel: UILabel!
    @IBOutlet private weak var inputStackView: UIStackView!
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
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    @IBAction func handleNumberButton(_ sender: UIButton) {
        if passcode.count == Constants.maxLengthPasscode {
            return
        }
        clearInput()
        errorTitleLabel.text = ""
        passcode += sender.titleLabel?.text ?? ""
        if passcode.count == Constants.maxLengthPasscode {
            passcodeTrigger.onNext(passcode)
        }
        for i in 0 ..< passcode.count {
            inputViews[i].backgroundColor = UIColor.init(hexString: "#526D82")
        }
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
        errorTitleLabel.text = ""
        switch viewModel.mode {
        case .new:
            titleLabel.text = L10n.Passcode.Title.new
        case .change:
            titleLabel.text = L10n.Passcode.Title.change
        case .confirmChange:
            titleLabel.text = L10n.Passcode.Title.Change.verify
        case .confirmNew:
            titleLabel.text = L10n.Passcode.Title.verify
        case .verify:
            titleLabel.text = L10n.Passcode.Title.verify
        case .unlock:
            titleLabel.text = L10n.Passcode.title
        }
    }
    
    private func clearInput() {
        inputViews.forEach { $0.backgroundColor = UIColor.init(hexString: "#D9D9D9") }
    }
    
    func bindViewModel() {
        let input = PasscodeViewModel.Input(passcodeTrigger: passcodeTrigger.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.error
            .drive(onNext: { [weak self] error in
                if let error = error {
                    self?.errorTitleLabel.text = error.description
                    self?.errorTitleLabel.isHidden = false
                    self?.springErrorAnimation()
                    self?.passcode = ""
                    self?.clearInput()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Binders
extension PasscodeViewController {
    
}

// MARK: - StoryboardSceneBased
extension PasscodeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.passcode
}

extension PasscodeViewController {
    func springErrorAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [-15, 15, -12, 12, -10, 10, -5, 5, 0]
        inputStackView.layer.add(animation, forKey: "shake")
    }
}
