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
    
    private let dataFileName = "zoo"
	
	let rootRef = Firebase(url: "https://\(kFirebaseAppId).firebaseio.com/")
    
    public var zoo: Zoo
    
    private init() {
        if let zoo = ZooFactory.zooFromJsonFileNamed(dataFileName) {
            self.zoo = zoo
        } else {
            self.zoo = Zoo(animals: nil, staff: nil)
        }
    }
	
	public func saveZoo() -> Bool {
		let result = ZooFactory.saveZoo(zoo, toFileNamed: dataFileName)
		if result {
			NSNotificationCenter.defaultCenter().postNotificationName(ZooDataNotifications.Updated.rawValue, object: nil)
		}
		return result
	}
}