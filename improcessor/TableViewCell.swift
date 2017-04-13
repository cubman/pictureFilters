//
//  TableViewCell.swift
//  improcessor
//
//  Created by student on 11.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class var defaultHeight: CGFloat { return 34 }
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var stack: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
