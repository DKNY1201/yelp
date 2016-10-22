//
//  YelpClient.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import AFNetworking
import BDBOAuth1Manager

// You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"

enum YelpSortMode: Int {
    case bestMatched = 0, distance, highestRated
}

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!

    static var _shared: YelpClient?
    static func shared() -> YelpClient! {
        if _shared == nil {
            _shared = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        }
        return _shared
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        let baseUrl = URL(string: "https://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);

        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }

//    func search(with term: String, completion: @escaping ([Business]?, Error?) -> ()) -> AFHTTPRequestOperation {
//        return search(with: term, sort: nil, categories: nil, deals: nil, completion: completion)
//    }

    func search(completion: @escaping ([Business]?, Error?) -> ()) -> AFHTTPRequestOperation {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api

        // Default the location to San Francisco
        let parameters = queryParamsWithSettings()
        
        print("parameters: \(parameters)")

        return self.get("search", parameters: parameters, success: { (operation: AFHTTPRequestOperation, response: Any) in
            if let response = response as? NSDictionary {
                let dictionaries = response["businesses"] as? [NSDictionary]
                if dictionaries != nil {
                    completion(Business.businesses(array: dictionaries!), nil)
                }
            }
            }, failure: { (operation: AFHTTPRequestOperation?, error: Error) in
                completion(nil, error)
        })!
    }
    
    func queryParamsWithSettings() -> [String: AnyObject] {
        let settings = BusinessSearchSetting.sharedInstance
        var parameters: [String:AnyObject] = [:]
        
        if let term = settings.term {
            parameters["term"] = term
        }
        
        if let ll = settings.ll {
            parameters["ll"] = ll
        }
        
        if let sort = settings.sort {
            parameters["sort"] = sort
        }
        
        if let categoryFilter = settings.categoryFilter {
            parameters["category_filter"] = categoryFilter
        }
        
        if let dealFilter = settings.dealFilter {
            parameters["deals_filter"] = dealFilter
        }
        
        return parameters
    }
}
