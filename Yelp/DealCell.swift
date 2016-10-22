//
//  DealCell.swift
//  Yelp
//
//  Created by Quy Tran on 10/22/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

@objc protocol DealCellDelegate {
    @objc optional func dealCellDidSwitch(dealCell: DealCell)
}

class DealCell: UITableViewCell {

    @IBOutlet weak var dealSwitch: UISwitch!
    
    weak var delegate: DealCellDelegate!

    @IBAction func onSwitch(_ sender: UISwitch) {
        delegate.dealCellDidSwitch!(dealCell: self)
    }
}
