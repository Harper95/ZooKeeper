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
/**
 A class that contains a name, color, legCount?, and isMale
*/
public class Animal {
    var type: String
    var name: String
    var color: String
    var isMale: Bool
    var currentWeight: Float?
    var birthday: NSData?
    var photo: UIImage?
    
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
}

public class Duck : Animal, Quackable {
    
    public init(name: String, color: String, isMale: Bool) {
        super.init(type: "Duck", name: name, color: color, isMale: isMale)
    }
    /// This prints a duck quack
    public func quack() {
        print("Quack")
    }
}

public class Fish : Animal, Spawnable {
    
    public init(name: String, color: String, isMale: Bool) {
        super.init(type: "Fish", name: name, color: color, isMale: isMale)
    }
    /// spawns a fish
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




