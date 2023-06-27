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
    @IBOutlet weak var blurMenuView: UIView!
    @IBOutlet private weak var menuView: UIView!
    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var emptyTitleLabel: UILabel!
    @IBOutlet private weak var emptyImageView: UIImageView!
    @IBOutlet private weak var menuButton: UIButton!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var accountsTableView: UITableView!
    
    @IBOutlet weak var menuViewLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: MainViewModel!
    var disposeBag = DisposeBag()
    
    private let toSettingsTrigger = PublishSubject<Void>()
    
    var tableViewData: [CellData] = []
    
    private var isOpenMenu = false
    private var beginPoint: CGFloat = 0
    private var difference: CGFloat = 0
    
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
    @IBAction func handleMenuButton(_ sender: UIButton) {
        displayMenu()
    }
    
    private func configView() {
        emptyView.isHidden = true
        let menuVC: SideMenuViewController = SideMenuViewController.instantiate()
        menuVC.delegate = self
        menuVC.view.frame = menuView.bounds
        menuView.addSubview(menuVC.view)
        addChild(menuVC)
        menuVC.didMove(toParent: self)
        menuViewLeadingConstraint.constant = -(UIScreen.main.bounds.width * 2 / 3)
        blurMenuView.isHidden = true
        blurMenuView.backgroundColor = .black
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
    
    func displayMenu() {
        isOpenMenu.toggle()
        blurMenuView.alpha = isOpenMenu ? 0.5 : 0
        blurMenuView.isHidden = !isOpenMenu
        UIView.animate(withDuration: 0.2) {
            self.menuViewLeadingConstraint.constant = self.isOpenMenu ? 0 : -(UIScreen.main.bounds.width * 2 / 3)
            self.view.layoutIfNeeded()
        }
    }
    
    func bindViewModel() {
        let input = MainViewModel.Input(
            toAddAccountTrigger: addButton.rx.tap.asDriver(),
            toSettingsTrigger: toSettingsTrigger.asDriverOnErrorJustComplete()
        )
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
        footerView.backgroundColor = Asset.d9D9D9.color
        footerView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

extension MainViewController {
    private func showActionSheet(indexPath: IndexPath) {
        let alert = UIAlertController(title: L10n.Action.title, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: L10n.Action.cancel, style: .cancel)
        let deleteAction = UIAlertAction(title: L10n.Action.delete, style: .destructive, handler: { _ in
            print("Delete")
        })
        let editAction = UIAlertAction(title: L10n.Action.edit, style: .default) { _ in
            print("Edit")
        }
        alert.addAction(cancelAction)
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: SideMenuViewControllerDelegate
extension MainViewController: SideMenuViewControllerDelegate {
    func didSelectedClose() {
        displaySideMenu(isShow: false)
    }
    
    func didSelectedItem(item: MenuCellType) {
        switch item {
        case .settings:
            displaySideMenu(isShow: false)
            toSettingsTrigger.onNext(())
        default:
            break
        }
    }
}

// MARK: Handle menu animation
extension MainViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            let location = touch.location(in: blurMenuView)
            beginPoint = location.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: blurMenuView)
        let diffFromBeginPoint = location.x - beginPoint
        if isOpenMenu {
            if diffFromBeginPoint < 0, diffFromBeginPoint < Constants.widthMenuView {
                difference = diffFromBeginPoint
                menuViewLeadingConstraint.constant = diffFromBeginPoint
                blurMenuView.alpha = 0.5 * (1 - diffFromBeginPoint / -Constants.widthMenuView)
            }
        } else {
            if diffFromBeginPoint > 0, diffFromBeginPoint < Constants.widthMenuView {
                difference = diffFromBeginPoint
                menuViewLeadingConstraint.constant = diffFromBeginPoint - Constants.widthMenuView
                blurMenuView.alpha = 0.5 * (1 - (diffFromBeginPoint - Constants.widthMenuView) / -Constants.widthMenuView)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isOpenMenu {
            // When user only touch, doesn't swipe, if touch is outside menu -> hide menu
            if difference == 0, let touch = touches.first {
                let location = touch.location(in: blurMenuView)
                if !menuView.frame.contains(location) {
                    displaySideMenu(isShow: false)
                }
            } else if difference < -Constants.widthMenuView / 2 {
                displaySideMenu(isShow: false)
            } else {
                displaySideMenu(isShow: true)
            }
        } else {
            displaySideMenu(isShow: difference > Constants.widthMenuView / 2)
        }
        difference = 0
    }
    
    private func displaySideMenu(isShow: Bool) {
        blurMenuView.alpha = isShow ? 0.5 : 0
        blurMenuView.isHidden = !isShow
        UIView.animate(withDuration: 0.2) {
            self.menuViewLeadingConstraint.constant = isShow ? 0 : -Constants.widthMenuView
            self.view.layoutIfNeeded()
        }
        isOpenMenu = isShow
    }
}
