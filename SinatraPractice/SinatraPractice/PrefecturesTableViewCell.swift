//
//  PrefecturesTableViewCell.swift
//  SinatraPractice
//
//  Created by 坂本龍哉 on 2021/10/09.
//

import UIKit

final class PrefecturesTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configure(name: String) {
        nameLabel.text = name
    }
    
}
