//
//  NewChatViewController.swift
//  WubbyChat
//
//  Created by Matt Amerige on 12/21/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

import UIKit

class NewChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var _tableView: UITableView!
  @IBOutlet weak var _searchBar: UISearchBar!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath:indexPath)
    
    return cell
  }
  
  

}
