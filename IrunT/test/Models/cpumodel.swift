//
//  cpumodel.swift
//  test
//
//  Created by Alex Iakab on 14/12/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import Foundation

typealias CPUS = [CPU]

struct CPU: Codable {
    let ratings: String
    let name: String
    let price: String
    let cores: String
    let tdp: String
    let speed: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case ratings = "ratings"
        case name = "name"
        case price = "price"
        case cores = "cores"
        case tdp = "tdp"
        case speed = "speed"
        case id = "id"
    }
}
