//
//  Staff.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/11/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit
import Firebase

public class Staff {
    var type: String
    var name: String
    var isMale: Bool
    var currentWeight: Float?
    var birthday: NSDate?
	var imageBase64String: String?
	
	var key: String!
	var ref: Firebase?
    
    public init(type: String, name: String, isMale: Bool) {
        self.type = type
        self.name = name
        self.isMale = isMale
		self.key = nil
    }
	
	init(snapshot: FDataSnapshot) {
		key = snapshot.key
		ref = snapshot.ref
		type = snapshot.value["type"] as! String
		name = snapshot.value["name"] as! String
		isMale = snapshot.value["isMale"] as! Bool
		currentWeight = snapshot.value["currenWeight"] as? Float
		
		if let weight = snapshot.value["currenWeight"] as? Float where weight > 0 {
			currentWeight = weight
		}
		
		if let bDayString = snapshot.value["birthday"] as? String where !bDayString.isEmpty {
			let formatter = NSDateFormatter()
			formatter.dateFormat = dateFormatString
			self.birthday = formatter.dateFromString(bDayString)
		}
		
		if let string = snapshot.value["imageBase64String"] as? String where !string.isEmpty {
			self.imageBase64String = string
		}
	}
	
    deinit {
        print("Oh No \(name)!")
    }
    /**
     - Returns: A string descibing the staff member
     */
    public func report() -> String {
        return "I'm a \(isMale ? "male" : "female") and my name is \(name) "
    }
    
	public func hasCustomImage() -> Bool {
		return imageBase64String != nil
	}
	
	public func getImage() -> UIImage? {
		if let image = firebaseImage() {
			return image
		}
		return UIImage(named: type.lowercaseString)
	}
	
	private func firebaseImage() -> UIImage? {
		guard let string = imageBase64String,
			let data = NSData(base64EncodedString: string, options: .IgnoreUnknownCharacters),
			let image = UIImage(data: data) else { return nil }
		
		return image
	}
	
	public func saveImage(image: UIImage) -> Bool {
		if let data = UIImageJPEGRepresentation(image, 0.8) {
			imageBase64String = data.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
			ref!.updateChildValues(["imageBase64String": imageBase64String!])
			return true
		}
		return false
	}
	
	private func birthdayString() -> String? {
		guard let day = birthday else {return nil}
		
		let formatter = NSDateFormatter()
		formatter.dateFormat = dateFormatString
		return formatter.stringFromDate(day)
	}
	
	public static func dateFromString(string: String?) -> NSDate? {
		guard let string = string else {return nil}
		
		let formatter = NSDateFormatter()
		formatter.dateFormat = dateFormatString
		return formatter.dateFromString(string)
	}
	
	// Maps Json Objects to Swift Objects
	public func toDictionary() -> [String: AnyObject] {
		return [
			"type": type,
			"name": name,
			"isMale": isMale,
			"currentWeight": currentWeight ?? -1,
			"birthday" : birthdayString() ?? "",
			"imageBase64String": imageBase64String ?? ""
		]
	}
	
	public func updateInFB() {
		ref!.updateChildValues(toDictionary())
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
