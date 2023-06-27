//
//  MenuTableViewCell.swift
//  AccountKeeper
//
//  Created by NamTrinh on 26/06/2023.
//

import UIKit
import Reusable

final class MenuTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageUIView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        titleImageUIView.isHidden = true
    }

    func configCell(data: SettingCellData) {
        if let icon = data.icon {
            titleImageUIView.isHidden = false
            titleImageView.image = icon
        }
        titleLabel.text = data.title
    }
}
