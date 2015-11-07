//
//  resultTableViewCell.swift
//  Studie2
//
//  Created by johahogb on 07/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//

import UIKit

class resultTableViewCell: UITableViewCell {

    @IBOutlet weak var headlineLabel:UILabel!
    @IBOutlet weak var resultLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
