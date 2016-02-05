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

public class Animal {
    var name: String
    var color: String
    
    public init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    deinit {
        print("Oh No!")
    }
    
    public func report() {
        print("I'm a \(color) \(name)")
    }
}

public class Duck : Animal, Quackable {
    
    public init(color: String) {
        super.init(name: "Duck", color: color)
    }
    
    public func quack() {
        print("Quack")
    }
}

public class Fish : Animal, Spawnable {
    
    public init(color: String) {
        super.init(name: "Fish", color: color)
    }
    
    public func spawn() {
        print("long trip ahead...")
    }
}