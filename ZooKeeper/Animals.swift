//
//  Animal.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/4/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

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
	var photoFileName: String?
    
    public init(type: String, name: String, color: String, isMale: Bool) {
        self.type = type
        self.name = name
        self.color = color
        self.isMale = isMale
    }
    
    deinit {
        print("Oh No!")
    }
    /**
     - Returns: A string descibing the animal
    */
    public func report() -> String {
        return "I'm a \(isMale ? "male" : "female") \(color) \(name) "
    }
    
    public func image() -> UIImage? {
        return UIImage(named: type.lowercaseString)
    }
	
	public func hasImage() -> Bool {
		return photoFileName != nil
	}
	
	public func saveImage(image: UIImage) -> Bool {
		if let data = UIImageJPEGRepresentation(image, 0.8) {
			photoFileName = NSUUID().UUIDString + ".jpg"
			let path = CTHPathToFileInDocumentsDirectory(photoFileName!)
			return data.writeToFile(path, atomically: true)
		}
	return false
	}
	
	public func loadImage() -> UIImage? {
		guard let filename = photoFileName,
			let path = CTHPathToExistingFileInDocumentsDirectory(filename),
			let image = UIImage(contentsOfFile: path) else { return nil }
		
		return image
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
				"photoFileName": photoFileName ?? ""
		]
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




