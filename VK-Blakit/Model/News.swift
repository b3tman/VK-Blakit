//
//  News.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 08.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation
import SwiftyJSON

struct News {
    
    let sourceID: Int
    let date: Date
    let text: String
    var postIcon: String?
    
    init(params: JSON) {
        self.sourceID = params["from_id"].intValue
        let dateUnixTime = params["date"].intValue
        self.date = Date(timeIntervalSince1970: TimeInterval(dateUnixTime))
        self.text = params["text"].stringValue
        
        let attachments = params["attachments"].arrayValue
        for attachment in attachments {
            if attachment["type"].stringValue == "photo" {
                let imageSizesDict = attachment["photo"].dictionaryValue
                self.postIcon = imageSizesDict["photo_604"]?.string
            }
        }
    }
}
