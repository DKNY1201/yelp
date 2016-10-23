//
//  BusinessDetailViewController.swift
//  Yelp
//
//  Created by Quy Tran on 10/23/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

class BusinessDetailViewController: UIViewController {

    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var businessImage: UIImageView!
    
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        businessName.text = business.name
        ratingImage.setImageWith(business.ratingImageURL!)
        phoneLabel.text = business.phoneNumber
        addressLabel.text = business.address
        businessImage.setImageWith(business.imageURL!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
