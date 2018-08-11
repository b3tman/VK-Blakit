//
//  DeclineWord.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 08.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation

struct DeclinedWord {
    var single: String
    var several: String
    var many: String
}

extension DeclinedWord {
    static let second = DeclinedWord(single: "секунду", several: "секунды", many: "секунд")
    static let minute = DeclinedWord(single: "минуту", several: "минуты", many: "минут")
    static let hour = DeclinedWord(single: "час", several: "часа", many: "часов")
    static let year = DeclinedWord(single: "год", several: "года", many: "лет")
}
