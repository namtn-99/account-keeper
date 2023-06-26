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

struct CellData {
    var opened: Bool
    var title: String
    var sectionData: [String]
}

final class MainViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var emptyTitleLabel: UILabel!
    @IBOutlet private weak var emptyImageView: UIImageView!
    @IBOutlet private weak var menuButton: UIButton!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var accountsTableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: MainViewModel!
    var disposeBag = DisposeBag()
    
    var tableViewData: [CellData] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Methods
    private func configView() {
        emptyView.isHidden = true
    }
    
    private func configTableView() {
        accountsTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: AccountSectionTableViewCell.self)
            $0.register(cellType: AccountTableViewCell.self)
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 100
            
        }
        
        tableViewData = [CellData(opened: false, title: "Title1", sectionData: ["Cell1", "Cell2", "Cell3", "Cell4"]),
                         CellData(opened: false, title: "Title2", sectionData: ["Cell1", "Cell2"]),
                         CellData(opened: false, title: "Title3", sectionData: ["Cell1", "Cell2", "Cell3"])]
    }
    
    func bindViewModel() {
        let input = MainViewModel.Input(toAddAccountTrigger: addButton.rx.tap.asDriver())
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened {
            return tableViewData[section].sectionData.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: AccountSectionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configCell(with: tableViewData[indexPath.section])
            return cell
        } else {
            let cell: AccountTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.editSelected = { [weak self] in
                self?.showActionSheet(indexPath: indexPath)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .automatic)
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 12))
        footerView.backgroundColor = UIColor(red: 217, green: 217, blue: 217)
        footerView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

extension MainViewController {
    private func showActionSheet(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit account", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            print("Delete")
        })
        let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
            print("Edit")
        }
        alert.addAction(cancelAction)
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
    }
}
