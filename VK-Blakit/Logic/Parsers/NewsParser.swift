//
//  NewsParser.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 11.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsParser: NSObject {
    
    public func parseResponse(from json: JSON) -> [News]? {
        guard let newsJSONArray = json["items"].array else { return nil }
        var news = [News]()
        for newsJSON in newsJSONArray {
            let newsItem = News(params: newsJSON)
            news.append(newsItem)
        }
        
        return news
    }
}
