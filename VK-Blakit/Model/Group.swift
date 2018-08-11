//
//  Group.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 08.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Group: Source {
    
    var id: Int
    var name: String
    var photoURL: String
    
    init(params: JSON) {
        self.name = params["name"].stringValue
        self.id = params["id"].intValue
        self.photoURL = params["photo_100"].stringValue
    }
}
