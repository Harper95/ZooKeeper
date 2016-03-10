//
//  Animal.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/4/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit
import Firebase

protocol Quackable {
    func quack()
}

protocol Spawnable {
    func spawn()
}

let dateFormatString = "dd-MM-yy"

/**
 A class that contains a name, color, legCount?, and isMale
*/
public class Animal {
    var type: String
    var name: String
    var color: String
    var isMale: Bool
    var currentWeight: Float?
    var birthday: NSDate?
	var imageBase64String: String?
	
	var key: String!
	var ref: Firebase?
    
    init(type: String, name: String, color: String, isMale: Bool) {
        self.type = type
        self.name = name
        self.color = color
        self.isMale = isMale
		self.key = nil
    }
	
	init(snapshot: FDataSnapshot) {
		key = snapshot.key
		ref = snapshot.ref
		type = snapshot.value["type"] as! String
		name = snapshot.value["name"] as! String
		color = snapshot.value["color"] as! String
		isMale = snapshot.value["isMale"] as! Bool
		
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
     - Returns: A string descibing the animal
    */
    public func report() -> String {
        return "I'm a \(isMale ? "male" : "female") \(color) \(name) "
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
	
	public func firebaseImage() -> UIImage? {
		guard let string = imageBase64String,
			let data = NSData(base64EncodedString: string, options: .IgnoreUnknownCharacters),
			let image = UIImage(data: data) else { return nil }
		
		return image
	}
	
	public func saveImage(image: UIImage) -> Bool {
		if let smallImage = image.normalizedImage().scaledInside(CGSize(width: 500, height: 500)),
			let data = UIImageJPEGRepresentation(smallImage, 0.8) {
				imageBase64String = data.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
				ref!.updateChildValues(["imageBase64String": self.imageBase64String!])
				
				let avatarRef = ZooData.sharedInstance.animalAvatarRef.childByAppendingPath(key)
				avatarRef.setValue(["name": name, "imageString": self.imageBase64String!])
				
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
				"color": color,
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

public class Duck : Animal, Quackable {
    
    public init(name: String, color: String, isMale: Bool) {
        super.init(type: "Duck", name: name, color: color, isMale: isMale)
    }

	public func quack() {
        print("Quack")
    }
}

public class Fish : Animal, Spawnable {
    
    public init(name: String, color: String, isMale: Bool) {
        super.init(type: "Fish", name: name, color: color, isMale: isMale)
    }

	public func spawn() {
        print("long trip ahead...")
    }
}

public class Bear : Animal {
    public init(name: String, color: String, isMale: Bool) {
        super.init(type: "Bear", name: name, color: color, isMale: isMale)
    }
}

public class Lion : Animal {
    public init(name: String, color: String, isMale: Bool) {
        super.init(type: "Lion", name: name, color: color, isMale: isMale)
    }
}

public class Seal : Animal {
    public init(name: String, color: String, isMale: Bool) {
        super.init(type: "Seal", name: name, color: color, isMale: isMale)
    }
}




