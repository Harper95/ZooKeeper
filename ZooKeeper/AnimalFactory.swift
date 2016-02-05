//
//  AnimalFactory.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/4/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import Foundation
import SwiftyJSON

public class AnimalFactory {
    
    public static func zooFromJSONFileNamed(name: String) -> [Animal]? {
        if let path = NSBundle.mainBundle().pathForResource("zoo", ofType: "json"),
            let contentData = NSFileManager.defaultManager().contentsAtPath(path) {
                
                let json = JSON(data: contentData)
                var zoo = [Animal]()
                
                if let animals = json["animals"].array {
                    for ii in animals {
                        if let object = AnimalFactory.animalFromJSON(ii) {
                            zoo.append(object)
                        }
                    }
                    
                }
                return zoo
        }
        return nil
    }
    
    public static func animalFromJSON(json: JSON) -> Animal? {
        
        let color: String = json["color"].stringValue
        let type: String = json["type"].stringValue
        
        if type == "Duck" {
            return Duck(color: color)
        } else if type == "Fish" {
            return Fish(color: color)
        }
        
        return nil
    }
}