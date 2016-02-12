//
//  StaffFactory.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/11/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import Foundation
import SwiftyJSON

public class StaffFactory {
    
    public static func zooFromJSONFileNamed(name: String) -> [Staff]? {
        if let path = NSBundle.mainBundle().pathForResource("zoo", ofType: "json"),
            let contentData = NSFileManager.defaultManager().contentsAtPath(path) {
                
                let json = JSON(data: contentData)
                var zoo = [Staff]()
                
                if let staff = json["staff"].array {
                    for ii in staff {
                        if let object = StaffFactory.staffFromJSON(ii) {
                            zoo.append(object)
                        }
                    }
                    
                }
                return zoo
        }
        return nil
    }
    
    public static func staffFromJSON(json: JSON) -> Staff? {
        
        let name: String = json["name"].stringValue
        let type: String = json["type"].stringValue
        let isMale: Bool = json["isMale"].boolValue
        
        switch type {
        case "ZooKeeper":
            return ZooKeeper(name: name, isMale: isMale)
        case "TicketTaker":
            return TicketTaker(name: name, isMale: isMale)
        default:
            return nil
        }
    }
}
