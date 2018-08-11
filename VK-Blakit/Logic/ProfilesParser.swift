//
//  ProfilesParser.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 11.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProfilesParser: NSObject {
    
    public func parseResponse(from json: JSON) -> [Int : Profile]? {
        guard let profilesJSONArray = json["profiles"].array else { return nil }
        
        var profiles = [Int : Profile]()
        
        for profileJSON in profilesJSONArray {
            let profile = Profile(params: profileJSON)
            profiles[profile.id] = profile
        }
        
        return profiles
    }
}
