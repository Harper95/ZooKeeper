//
//  Zoo.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/18/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import Foundation

public class Zoo {
    public var animals: [Animal]
    public var staff: [Staff]

    public init(animals: [Animal]?, staff: [Staff]?){
        self.animals = animals ?? [Animal]()
        self.staff = staff ?? [Staff]()
    }
}