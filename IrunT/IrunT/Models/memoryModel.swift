//
//  memoryModel.swift
//  test
//
//  Created by Alex Iakab on 19/12/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import Foundation

typealias Memorys = [Memory]

struct Memory: Codable, Hashable {
    let ratings: String
    let name: String
    let cas: String
    let speed: String
    let price: String
    let modules: String
    let priceGB: String
    let type: String
    let id: String
    let size: String
    
    enum CodingKeys: String, CodingKey {
        case ratings = "ratings"
        case name = "name"
        case cas = "cas"
        case speed = "speed"
        case price = "price"
        case modules = "modules"
        case priceGB = "price/gb"
        case type = "type"
        case id = "id"
        case size = "size"
    }
}
