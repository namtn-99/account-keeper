//
//  AccountSectionTableViewCell.swift
//  AccountKeeper
//
//  Created by NamTrinh on 23/06/2023.
//

import UIKit
import Reusable

final class AccountSectionTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet weak var logoHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var expandImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        contentView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
    }
    
    func configCell(with cellData: CellData) {
        UIView.animate(withDuration: 0.2,
                       delay: 0.1,
                       options: [.curveEaseInOut]) { [weak self] in
            self?.logoHeightConstraints.constant = cellData.opened ? 100 : 55
            self?.totalLabel.isHidden = cellData.opened
            self?.titleLabel.font = UIFont.systemFont(ofSize: cellData.opened ? 25 : 16)
            self?.expandImageView.image = UIImage(named: cellData.opened ? "ic_expand_less" : "ic_expand_more")
        }
    }
}
