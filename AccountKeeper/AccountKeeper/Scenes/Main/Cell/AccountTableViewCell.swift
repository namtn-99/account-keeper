//
//  AccountTableViewCell.swift
//  AccountKeeper
//
//  Created by NamTrinh on 24/06/2023.
//

import UIKit
import Reusable

final class AccountTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var qrCodeView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var qrCodeLabel: UILabel!
    @IBOutlet weak var usernameTitleLabel: UILabel!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var qrCodeTitleLabel: UILabel!
    var editSelected: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        selectionStyle = .none
        nameTitleLabel.text = L10n.name
        usernameTitleLabel.text = L10n.username
        passwordTitleLabel.text = L10n.password
        qrCodeTitleLabel.text = L10n.qrCode
    }
    
    @IBAction func handleEditButton(_ sender: UIButton) {
        editSelected?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}
