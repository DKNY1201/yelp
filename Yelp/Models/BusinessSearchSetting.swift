//
//  BusinessSearchSetting.swift
//  Yelp
//
//  Created by Quy Tran on 10/22/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import Foundation

class BusinessSearchSetting {
    var term: AnyObject?
    var ll: AnyObject? = "37.785771,-122.406165" as AnyObject?
    var sort = ""
    var categoryFilter: String?
    var dealFilter: AnyObject?
    var radiusFilter: Double?
    var radiusFilterStored = ""
    
    static let sharedInstance = BusinessSearchSetting()
}
