//
//  Staff.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/11/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

public class Staff {
    var type: String
    var name: String
    var isMale: Bool
    var currentWeight: Float?
    var birthday: NSDate?
    var photo: UIImage?
    
    public init(type: String, name: String, isMale: Bool) {
        self.type = type
        self.name = name
        self.isMale = isMale
    }
    
    deinit {
        print("Oh No!")
    }
    /**
     - Returns: A string descibing the animal
     */
    public func report() -> String {
        return "I'm a \(isMale ? "male" : "female") and my name is \(name) "
    }
    
    public func image() -> UIImage? {
        return UIImage(named: type.lowercaseString)
    }
	// Maps Json Objects to Swift Objects
	public func toDictionary() -> [String: AnyObject] {
		return ["type": type, "name": name, "isMale": isMale]
	}

}
public class ZooKeeper : Staff {
    public init(name: String, isMale: Bool) {
        super.init(type: "ZooKeeper", name: name, isMale: isMale)
    }
}
public class TicketTaker : Staff {
    public init(name: String, isMale: Bool) {
        super.init(type: "TicketTaker", name: name, isMale: isMale)
    }
}
