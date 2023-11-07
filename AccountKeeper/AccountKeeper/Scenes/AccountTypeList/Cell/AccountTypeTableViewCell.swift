//
//  AccountTypeTableViewCell.swift
//  AccountKeeper
//
//  Created by NamTrinh on 15/08/2023.
//

import UIKit
import Reusable

final class AccountTypeTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
