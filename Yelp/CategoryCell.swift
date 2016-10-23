//
//  CategoryCell.swift
//  Yelp
//
//  Created by Quy Tran on 10/22/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

@objc protocol CategoryCellDelegate {
    @objc optional func categoryCell(categoryCell: CategoryCell, didSwitchChange value: Bool)
}

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categorySwitch: UISwitch!
    
    weak var delegate: CategoryCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        print("Switching...")
        delegate?.categoryCell!(categoryCell: self, didSwitchChange: sender.isOn)
    }

}
