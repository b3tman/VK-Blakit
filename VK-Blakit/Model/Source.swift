//
//  Source.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 08.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation

protocol Source {
    
    var id: Int { get set }
    var name: String { get set }
    var photoURL: String { get set }
}
