//
//  TestUser.swift
//  WubbyChat
//
//  Created by Matt Amerige on 1/18/16.
//  Copyright © 2016 Wubbyland. All rights reserved.
//

/**
This class is used to represent the User object for parse. It will be used to generate fake user objects
for testing.
*/

import UIKit

@objc class TestUser : PFObject, PFSubclassing {
  
  @NSManaged var displayName : String
  @NSManaged var profilePicture : PFFile
  
  
  override class func initialize() {
    struct Static {
      static var onceToken : dispatch_once_t = 0
    }
    dispatch_once(&Static.onceToken) {
      self.registerSubclass()
    }
  }
  
  static func parseClassName() -> String {
    return "TestUser"
  }
}