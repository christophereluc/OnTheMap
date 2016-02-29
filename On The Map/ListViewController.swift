//
//  ListViewController.swift
//  On The Map
//
//  Created by Christopher Luc on 2/17/16.
//  Copyright © 2016 Christopher Luc. All rights reserved.
//

import Foundation
import UIKit

class ListViewController : BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func logout(sender: AnyObject) {
        logout()
    }
    
    @IBAction func refreshData(sender: AnyObject) {
        tableView.reloadData()
        fetchData()
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentInfo.studentInfoDictionary.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as UITableViewCell!
        cell.textLabel?.text = StudentInfo.studentInfoDictionary[indexPath.row].title
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        launchLink(StudentInfo.studentInfoDictionary[indexPath.row].mediaURL)
    }
    
    override func dataRetrieved() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
}