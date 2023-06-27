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
    
    private func configTableView() {
        settingsTableView.do {
            $0.delegate = self
            $0.dataSource = self
            
        }
    }
    
    func bindViewModel() {
        let input = SettingsViewModel.Input(dissmissTrigger: closeButton.rx.tap.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input, disposeBag: disposeBag)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
