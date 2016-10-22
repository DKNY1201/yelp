//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Quy Tran on 10/22/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewControllerDidUpdate(filtersViewController: FiltersViewController)
}

class FiltersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let dealCellReuseID = "DealCell"
    let distanceCellReuseID = "DistanceCell"
    let sortCellReuseID = "SortbyCell"
    let categoryCellReuseID = "CategoryCell"
    
    var dealOffer = false
    var distanceArr = [0.3, 1, 5, 20]
    var sortbyArr = ["Best match", "Distance", "Rate"]
    var categories = getCategories()
    
    weak var delegate: FiltersViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onSearch(_ sender: UIBarButtonItem) {
        let settings = BusinessSearchSetting.sharedInstance
        settings.dealFilter = dealOffer as AnyObject?
        delegate.filtersViewControllerDidUpdate!(filtersViewController: self)
        dismiss(animated: true, completion: nil)
    }
    
   
    
}

func getCategories() -> [[String: String]] {
    let categories: [Dictionary<String, String>] = [["name" : "Afghan", "code": "afghani"],
                                                    ["name" : "African", "code": "african"],
                                                    ["name" : "American, New", "code": "newamerican"],
                                                    ["name" : "American, Traditional", "code": "tradamerican"],
                                                    ["name" : "Arabian", "code": "arabian"],
                                                    ["name" : "Argentine", "code": "argentine"],
                                                    ["name" : "Armenian", "code": "armenian"],
                                                    ["name" : "Asian Fusion", "code": "asianfusion"],
                                                    ["name" : "Asturian", "code": "asturian"],
                                                    ["name" : "Australian", "code": "australian"],
                                                    ["name" : "Austrian", "code": "austrian"],
                                                    ["name" : "Baguettes", "code": "baguettes"],
                                                    ["name" : "Bangladeshi", "code": "bangladeshi"],
                                                    ["name" : "Barbeque", "code": "bbq"],
                                                    ["name" : "Basque", "code": "basque"],
                                                    ["name" : "Bavarian", "code": "bavarian"],
                                                    ["name" : "Beer Garden", "code": "beergarden"],
                                                    ["name" : "Beer Hall", "code": "beerhall"],
                                                    ["name" : "Beisl", "code": "beisl"],
                                                    ["name" : "Belgian", "code": "belgian"],
                                                    ["name" : "Bistros", "code": "bistros"]]
    return categories
}


extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3: return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: dealCellReuseID) as! DealCell
            cell.delegate = self
            return cell
//        case 1:
//            return 1
//        case 2:
//            return 1
//        case 3: return 1
        default:
            return UITableViewCell()
        }
    }
}

extension FiltersViewController: DealCellDelegate {
    func dealCellDidSwitch(dealCell: DealCell) {
        print("Deal offer changed...")
        dealOffer = dealCell.dealSwitch.isOn
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}
