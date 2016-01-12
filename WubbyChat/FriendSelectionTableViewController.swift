//
//  FriendSelectionTableViewController.swift
//  WubbyChat
//
//  Created by Matt Amerige on 1/11/16.
//  Copyright © 2016 Wubbyland. All rights reserved.
//
/**
  Class Description: This table view controller presents a friends list to the user. The cells contain the friends name and a button that indicates whether 
  that friend has been selected or not. 

  Data Structures: An array consisting of all the friends the user has selected. Each selection/deselection will add or remove friends from the array, respectively.

  Operations: Upon loading the view this class will query parse for an array of friends that the user has. These friends are other friends who also use this app. (note:
  in the future I may include something to invite friends who do not currently have the app, but that should be done in another viewController separate from this one.)

  Unsolved problems: This class will need a way of reporting the array data back to its parentViewController. I think that keeping the array as the default 'internal' access control should do the job. Will update when I come to that area. First I'm just going to add some fake data to get the table view up and running.

*/

import UIKit

class FriendSelectionTableViewController: UITableViewController {
  
  //MARK: - UITableViewController Datasource & Delegate Methods
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 50
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell") as! FriendSelectionTableViewCell
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.cellForRowAtIndexPath(indexPath) as! FriendSelectionTableViewCell
    cell.selectionButton.isFilled = !cell.selectionButton.isFilled
  }



}
