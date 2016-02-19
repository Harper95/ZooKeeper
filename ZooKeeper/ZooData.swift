//
//  ZooData.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/18/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import Foundation

public class ZooData {

    public static let sharedInstance = ZooData()
    
    private let dataFileName = "zoo"
    
    public var zoo: Zoo
    
    private init() {
        if let zoo = ZooFactory.zooFromJsonFileNamed(dataFileName) {
            self.zoo = zoo
        } else {
            self.zoo = Zoo(animals: nil, staff: nil)
        }
    }
}