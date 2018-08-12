//
//  GroupsParser.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 11.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation
import SwiftyJSON

class GroupsParser: NSObject {
    
    public func parseResponse(from json: JSON) -> [Int : Group]? {
        guard let groupsJSONArray = json["groups"].array else { return nil }
        var groups = [Int : Group]()
        for groupJSON in groupsJSONArray {
            let group = Group(params: groupJSON)
            groups[-group.id] = group
        }
        
        return groups
    }
}
