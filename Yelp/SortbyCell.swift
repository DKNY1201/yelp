//
//  SortbyCell.swift
//  Yelp
//
//  Created by Quy Tran on 10/22/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

class SortbyCell: UITableViewCell {

    
    @IBOutlet weak var sortbyLabel: UILabel!
    @IBOutlet weak var sortbyCheckImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sortbyCheckImage.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
