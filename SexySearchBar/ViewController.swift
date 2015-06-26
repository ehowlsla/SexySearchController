//
//  ViewController.swift
//  SexySearchBar
//
//  Created by YoonTaesup on 2015. 6. 26..
//  Copyright (c) 2015년 com.SexyDynamite. All rights reserved.
//

import UIKit

class ViewController: UIViewController,   UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource{
    
    var searchController: UISearchController!
    var tableView:UITableView!
    
    var array = [String]()
    var filteredArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "메인"
        
        array = ["Apples", "Butter", "Charlie", "Duff", "Edward", "Freddy", "George", "Harry", "Ink", "Johnnie", "King", "London", "Monkey", "Nuts", "Orange", "Pudding", "Queenie", "Robert", "Sugar", "Tommy", "Uncle", "Vinegar", "Willie", "Xerxes", "Yellow", "Zebra"]
        filteredArray = array
        
        self.view.backgroundColor = UIColor.brownColor()
        
        searchController = UISearchController(searchResultsController: UIViewController())
        
        // The object responsible for updating the contents of the search results controller.
        searchController.searchResultsUpdater = self
        
        // Determines whether the underlying content is dimmed during a search.
        // if we are presenting the display results in the same view, this should be false
        searchController.dimsBackgroundDuringPresentation = false
        
        // Make sure the that the search bar is visible within the navigation bar.
        searchController.searchBar.sizeToFit()
        searchController.searchBar.showsCancelButton = true
        
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        // Include the search controller's search bar within the table's header view.
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
        self.view.addSubview(tableView)
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // No need to update anything if we're being dismissed.

        if(searchController.searchBar.text == "") {
            filteredArray = array
        } else {
            filteredArray = array.filter({value -> Bool in
                println(value.rangeOfString(searchController.searchBar.text) != nil)
                return value.rangeOfString(searchController.searchBar.text) != nil
            })
        }
        
        
        if !searchController.active {
            return
        }
        
        tableView.frame = CGRectMake(0, 0, tableView.frame.size.width, 45 * CGFloat(filteredArray.count) + self.navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.height)
        
        tableView .reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        var cell:UITableViewCell = UITableViewCell(frame: CGRectMake(0, 0, self.view.frame.size.width, 45))

        cell.textLabel?.text = filteredArray[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

