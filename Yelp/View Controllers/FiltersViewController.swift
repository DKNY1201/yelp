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
    
    var dealOffer: Bool? = false
    
    var distanceArr: [[String:String]] = [["distanceName": "1 mile", "value": "1"], ["distanceName": "5 miles", "value": "5"], ["distanceName": "10 miles", "value": "10"], ["distanceName": "20 miles", "value": "20"]]
    var distanceSelected = ""
    
    var sortbyArr: [[String:String]] = [["sortName": "Best match", "value": "0"], ["sortName": "Distance", "value": "1"], ["sortName": "Rating", "value": "2"]]
    var sortbySelected = ""
    
    var categories = getCategories()
    var switchState = [Int:Bool]()
    
    let sectionTitles = ["", "Distance", "Sort By", "Category"]
    
    weak var delegate: FiltersViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let settings = BusinessSearchSetting.sharedInstance
        
        dealOffer = (settings.dealFilter != nil) ? true : false
        
        distanceSelected = settings.radiusFilterStored
        if distanceSelected == "" {
            distanceSelected = distanceArr[0]["value"]!
        }
        
        sortbySelected = settings.sort
        if sortbySelected == "" {
            sortbySelected = sortbyArr[0]["value"]!
        }
//        
//        let categoriesStored = settings.categoryFilter
//        if let categoryArr = categoriesStored?.components(separatedBy: ",") {
//            for cat in categoryArr {
//                for category in categories {
//                    if cat == category["code"] {
//                        
//                    }
//                }
//            }
//        }
        
        
        
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
        if dealOffer == false {
            dealOffer = nil
        }
        settings.dealFilter = dealOffer as AnyObject?
        settings.radiusFilter = Double(distanceSelected)
        settings.radiusFilterStored = distanceSelected
        settings.sort = sortbySelected
        
        var categoriesArr = [String]()
        if switchState.count > 0 {
            for (key, _) in switchState {
                let code = self.categories[key]["code"]
                categoriesArr.append(code!)
            }
        }

        settings.categoryFilter = categoriesArr.joined(separator: ",")
        
        
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
            return distanceArr.count > 0 ? distanceArr.count : 0
        case 2:
            return sortbyArr.count > 0 ? sortbyArr.count : 0
        case 3:
            return categories.count > 0 ? categories.count : 0
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
            cell.dealSwitch.isOn = dealOffer!
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: distanceCellReuseID) as! DistanceCell
            let distance = distanceArr[indexPath.row]
            cell.distanceLabel.text = distance["distanceName"]
            cell.distanceCheckImage.isHidden = distance["value"] != distanceSelected
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: sortCellReuseID) as! SortbyCell
            let sortby = sortbyArr[indexPath.row]
            cell.sortbyLabel.text = sortby["sortName"]
            cell.sortbyCheckImage.isHidden = sortby["value"] != sortbySelected
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellReuseID) as! CategoryCell
            let category = categories[indexPath.row]
            cell.categoryLabel.text = category["name"]
            cell.categorySwitch.isOn = false
//            if switchState.count > 0 {
//                for (key, _) in switchState {
//                    if (indexPath.row == key) {
//                        cell.categorySwitch.isOn = true
//                    } else {
//                        cell.categorySwitch.isOn = false
//                    }
//                }
//            } else {
//                cell.categorySwitch.isOn = false
//            }
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 1 {
            distanceSelected = distanceArr[(indexPath as NSIndexPath).row]["value"]!
            tableView.reloadSections(IndexSet(integer: 1), with: .none)
        } else if (indexPath as NSIndexPath).section == 2 {
            sortbySelected = sortbyArr[(indexPath as NSIndexPath).row]["value"]!
            tableView.reloadSections(IndexSet(integer: 2), with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles[section]
    }
}

extension FiltersViewController: DealCellDelegate {
    func dealCellDidSwitch(dealCell: DealCell) {
        dealOffer = dealCell.dealSwitch.isOn
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}

extension FiltersViewController: CategoryCellDelegate {
    func categoryCell(categoryCell: CategoryCell, didSwitchChange value: Bool) {
        print("have just switched")
        let indexPath = tableView.indexPath(for: categoryCell)
        switchState[(indexPath?.row)!] = value
    }
}
