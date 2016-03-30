//
//  ZooData.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/18/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import Foundation
import Firebase

let kFirebaseAppId = "cthzookeeper"

enum ZooDataNotifications: String {
	case Updated = "com.ctharper.zoodata.Updated"
}

public class ZooData {
	// Creation of a singleton
    public static let sharedInstance = ZooData()
	
	let rootRef = Firebase(url: "https://\(kFirebaseAppId).firebaseio.com/")
	let animalAvatarRef = Firebase(url: "https://\(kFirebaseAppId).firebaseio.com/avatars/animals")
	let staffAvatarRef = Firebase(url: "https://\(kFirebaseAppId).firebaseio.com/avatars/staff")
    
    public var zoo: Zoo
    
    private init() {
		self.zoo = Zoo(animals: nil, staff: nil)
    }
}