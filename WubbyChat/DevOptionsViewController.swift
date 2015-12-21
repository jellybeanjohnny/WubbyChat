//
//  DevOptionsViewController.swift
//  WubbyChat
//
//  Created by Matt Amerige on 12/20/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

import UIKit

class DevOptionsViewController: UIViewController {
  
  @IBAction func _logout(sender: AnyObject) {
    PFUser.logOut()
  }

}
