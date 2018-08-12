//
//  Profile.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 08.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Profile: Source {
    var id: Int
    var name: String
    var photoURL: String
    
    init(params: JSON) {
        let firstName = params["first_name"].stringValue
        let lastName = params["last_name"].stringValue
        self.name = firstName + " " + lastName
        self.id = params["id"].intValue
        self.photoURL = params["photo"].stringValue
    }
}
