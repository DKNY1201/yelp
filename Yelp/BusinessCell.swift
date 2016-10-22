//
//  BusinessCell.swift
//  Yelp
//
//  Created by Quy Tran on 10/22/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var business: Business! {
        didSet {
            businessImage.setImageWith(business.imageURL!)
            businessNameLabel.text = business.name
            distanceLabel.text = business.distance
            reviewImage.setImageWith(business.ratingImageURL!)
            reviewCountLabel.text = "\(business.reviewCount!) Reviews"
            addressLabel.text = business.address
            categoryLabel.text = business.categories
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // create conner for business image
        businessImage.layer.cornerRadius = 3
        businessImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
