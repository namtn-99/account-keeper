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

final class SettingsViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Properties
    
    var viewModel: SettingsViewModel!
    var disposeBag = DisposeBag()
    
    var settingsSections: [SettingsSection] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        
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
            loadTrigger: Driver.just(()),
            dissmissTrigger: closeButton.rx.tap.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.settingsSections
            .drive(onNext: { [weak self] settingsSections in
                self?.settingsSections = settingsSections
                self?.settingsTableView.reloadData()
            })
            .disposed(by: disposeBag)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsSections[section].type.title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
