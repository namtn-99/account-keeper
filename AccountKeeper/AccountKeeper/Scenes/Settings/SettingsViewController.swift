//
//  SettingsViewController.swift
//  AccountKeeper
//
//  Created by NamTrinh on 26/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Then
import LocalAuthentication

final class SettingsViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var settingsTableView: UITableView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: SettingsViewModel!
    var disposeBag = DisposeBag()
    
    private let actionTrigger = PublishSubject<SettingsCellType>()
    private let loadTrigger = PublishSubject<Void>()
    private let turnOffPasscodeTrigger = PublishSubject<Void>()
    private let biometricSettingsTrigger = PublishSubject<Bool>()
    
    var settingsSections: [SettingsSection] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTrigger.onNext(())
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        titleLabel.text = L10n.Settings.title
    }
    
    private func configTableView() {
        settingsTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: SettingsTableViewCell.self)
            $0.rowHeight = 60
        }
    }
    
    func bindViewModel() {
        let input = SettingsViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            dissmissTrigger: closeButton.rx.tap.asDriverOnErrorJustComplete(),
            actionTrigger: actionTrigger.asDriverOnErrorJustComplete(),
            turnOffPasscode: turnOffPasscodeTrigger.asDriverOnErrorJustComplete(),
            biometricSettings: biometricSettingsTrigger.asDriverOnErrorJustComplete()
        )
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.settingsSections
            .drive(onNext: { [weak self] settingsSections in
                self?.settingsSections = settingsSections
                self?.settingsTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.reload
            .drive(onNext: { [weak self] _ in
                self?.loadTrigger.onNext(())
            })
            .disposed(by: disposeBag)
        
        output.confirmTurnOffPasscode
            .drive(onNext: { [weak self] _ in
                self?.showConfirmOffPasscode()
            })
            .disposed(by: disposeBag)
        
        loadTrigger.onNext(())
    }
}

// MARK: - Binders
extension SettingsViewController {
    
}

// MARK: - StoryboardSceneBased
extension SettingsViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.settings
}

// MARK:
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsSections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configCell(with: settingsSections[indexPath.section].cells[indexPath.row].getCellData())
        cell.didSelectedSwitch = { [weak self] isOn in
            if isOn {
                self?.requestPermission()
            } else {
                self?.biometricSettingsTrigger.onNext(isOn)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsSections[section].type.title
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return settingsSections[section].type.note
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionTrigger.onNext(settingsSections[indexPath.section].cells[indexPath.row])
    }
}

extension SettingsViewController {
    func showConfirmOffPasscode() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: L10n.Action.cancel, style: .cancel)
        let deleteAction = UIAlertAction(title: L10n.Settings.TurnPasscode.off,
                                         style: .destructive,
                                         handler: { [weak self] _ in
            self?.turnOffPasscodeTrigger.onNext(())
        })
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func requestPermission() {
        let context = LAContext()
        var error: NSError? = nil
        
        let permissions = context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        )
        
        if permissions {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authen") { success, error in
                guard success, error == nil else {
                    DispatchQueue.main.async {
                        self.settingsTableView.reloadData()
                    }
                    return
                }
                self.biometricSettingsTrigger.onNext(true)
            }
        } else {
            showNavigateToSettings(message: L10n.Settings.Popup.requestPremission)
            settingsTableView.reloadData()
        }
    }
}
