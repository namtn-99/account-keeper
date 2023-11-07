//
//  AccountTypeListViewController.swift
//  AccountKeeper
//
//  Created by NamTrinh on 13/08/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Then

final class AccountTypeListViewController: UIViewController, Bindable {
    // MARK: - IBOutlets
    @IBOutlet weak var accountTypesTableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Properties
    
    var viewModel: AccountTypeListViewModel!
    var disposeBag = DisposeBag()
    private var accountTypes: [AccountType] = []
    
    // Trigger
    private let edit = PublishSubject<AccountType>()
    private let delete = PublishSubject<AccountType>()
    
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
    
    private func configView() {
        accountTypesTableView.do {
            $0.register(cellType: AccountTypeTableViewCell.self)
            $0.rowHeight = UITableView.automaticDimension
        }
    }
    
    func bindViewModel() {
        let input = AccountTypeListViewModel.Input(
            load: Driver.just(()),
            dismiss: dismissButton.rx.tap.asDriver(),
            edit: edit.asDriverOnErrorJustComplete(),
            delete: delete.asDriverOnErrorJustComplete(),
            add: addButton.rx.tap.asDriver()
        )
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$accountType
            .asDriver()
            .drive(accountTypesBinder)
            .disposed(by: disposeBag)
    }
}

// MARK: - Binders
extension AccountTypeListViewController {
    var accountTypesBinder: Binder<[AccountType]> {
        return Binder(self) { vc, accounTypes in
            vc.accountTypes = accounTypes
            vc.accountTypesTableView.reloadData()
        }
    }
}

// MARK: - StoryboardSceneBased
extension AccountTypeListViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.accountTypeList
}

// MARK:
extension AccountTypeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accountTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccountTypeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] action, view, completion in
            guard let self = self else { return }
            self.edit.onNext(self.accountTypes[indexPath.row])
            completion(true)
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            self.delete.onNext(self.accountTypes[indexPath.row])
            completionHandler(true)
        }
        
        // swipe
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return swipe
    }
}
