//
//  SettingsTableViewCell.swift
//  AccountKeeper
//
//  Created by NamTrinh on 27/06/2023.
//

import UIKit
import Reusable

final class SettingsTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var actionSwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var actionImageView: UIImageView!
    @IBOutlet weak var switchView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        iconView.isHidden = true
    }
    
    func configCell(with data: SettingsCellData) {
        if let icon = data.icon {
            iconImageView.image = icon
            iconView.isHidden = false
        }
        titleLabel.text = data.title
        switch data.mode {
        case .disclosure:
            switchView.isHidden = true
            actionView.isHidden = false
        case .switch(let isOn):
            actionView.isHidden = true
            switchView.isHidden = false
            actionSwitch.isOn = isOn
        case .info:
            switchView.isHidden = true
            actionView.isHidden = true
        default:
            break
        }
    }
}
