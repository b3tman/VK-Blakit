//
//  NetworkManager.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 11.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation
import VK_ios_sdk
import SwiftyJSON

typealias Answer = (news: [News]?, profiles: [Int : Profile]?, groups: [Int : Group]?)
typealias Completion = (Answer?, _ error: String?) -> Void

class NetworkManager: NSObject {
    
    private let profilesParser = ProfilesParser()
    private let groupsParser = GroupsParser()
    private let newsParser = NewsParser()
    
    public func executeRequest(for id: Int, completion: @escaping Completion) {
        
        let getParameters: [String : Any] = ["owner_id": "\(id)", "count" : "10", "extended" : "1", "fields" : "photo"]
        
        if let request = VKRequest(method: "wall.get", parameters: getParameters) {
            request.execute(resultBlock: { (response) in
                if let jsonResponse = response {
                    let json = JSON(jsonResponse.json)
                    let news = self.newsParser.parseResponse(from: json)
                    let profiles = self.profilesParser.parseResponse(from: json)
                    let groups = self.groupsParser.parseResponse(from: json)
                    completion(Answer(news: news, profiles: profiles, groups: groups), nil)
                }
            }, errorBlock: { (error) in
                completion(nil, error?.localizedDescription)
            })
        }
    }
}
