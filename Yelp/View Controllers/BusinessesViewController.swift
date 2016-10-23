//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController {

    var businesses: [Business]!
    @IBOutlet weak var tableView: UITableView!
    let businessCellReuseID = "BusinessCell"
    
    var searchBar: UISearchBar!
    var searchSetting = BusinessSearchSetting.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
        
        doSearch()

        // Example of Yelp search with more search options specified
        /*
        Business.search(with: "Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses

                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
        }
        */
    }
    
    fileprivate func doSearch() {
        BusinessSearchSetting.sharedInstance.term = searchBar.text as AnyObject?
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search() { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                MBProgressHUD.hide(for: self.view, animated: true)
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextNC = segue.destination as? UINavigationController {
            let filterVC = nextNC.topViewController as? FiltersViewController
            filterVC?.delegate = self
        }
        
        if let nextVC = segue.destination as? BusinessDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow
            let business = businesses?[(indexPath?.row)!]
            nextVC.business = business
        }
    }

}

extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses != nil ? businesses.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: businessCellReuseID) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BusinessesViewController: UISearchBarDelegate {
    // SearchBar methods
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        doSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}

extension BusinessesViewController: FiltersViewControllerDelegate {
    func filtersViewControllerDidUpdate(filtersViewController: FiltersViewController) {
        doSearch()
    }
}
