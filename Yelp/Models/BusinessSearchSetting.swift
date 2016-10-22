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
    var sort: AnyObject?
    var categoryFilter: AnyObject?
    var dealFilter: AnyObject?
    
    static let sharedInstance = BusinessSearchSetting()
}
