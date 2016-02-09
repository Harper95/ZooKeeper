//
//  Animal.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/4/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import Foundation

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
    var name: String
    var color: String
    var legCount: Int?
    var isMale: Bool
    
    public init(name: String, color: String, isMale: Bool) {
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
}

public class Duck : Animal, Quackable {
    
    public init(color: String, isMale: Bool) {
        super.init(name: "Duck", color: color, isMale: isMale)
        legCount = 2
    }
    /// This prints a duck quack
    public func quack() {
        print("Quack")
    }
}

public class Fish : Animal, Spawnable {
    
    public init(color: String, isMale: Bool) {
        super.init(name: "Fish", color: color, isMale: isMale)
        legCount = 0
    }
    /// spawns a fish
    public func spawn() {
        print("long trip ahead...")
    }
}