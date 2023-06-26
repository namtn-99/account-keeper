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
    
    var editSelected: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    @IBAction func handleEditButton(_ sender: UIButton) {
        editSelected?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}
