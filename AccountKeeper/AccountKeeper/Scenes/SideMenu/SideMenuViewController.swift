//
//  SideMenuViewController.swift
//  AccountKeeper
//
//  Created by NamTrinh on 26/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Then

protocol SideMenuViewControllerDelegate: AnyObject {
    func didSelectedClose()
    func didSelectedItem(item: MenuCellType)
}

final class SideMenuViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var menuTableView: UITableView!
    @IBOutlet private weak var versionLabel: UILabel!
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    weak var delegate: SideMenuViewControllerDelegate?
    
    private let menuItems: [MenuCellType] = [
        .support,
        .settings
    ]
    
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
    @IBAction func handleCloseButton(_ sender: UIButton) {
        delegate?.didSelectedClose()
    }
    
    private func configView() {
        let appVersion = Bundle.main.releaseVersion ?? ""
        versionLabel.text = L10n.Menu.version("\(appVersion)")
    }
    
    private func configTableView() {
        menuTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: MenuTableViewCell.self)
            $0.rowHeight = 60
        }
    }
}

// MARK: - StoryboardSceneBased
extension SideMenuViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.sideMenu
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configCell(data: menuItems[indexPath.row].getCellData())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedItem(item: menuItems[indexPath.row])
    }
}
