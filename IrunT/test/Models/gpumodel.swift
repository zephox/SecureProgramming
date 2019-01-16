//
//  gpumodel.swift
//  test
//
//  Created by Alex Iakab on 29/11/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import Foundation

typealias GPUS = [GPU]

struct GPU: Codable {
    let rating: String
    let name: String
    let series: String
    let price: String
    let coreClock: String
    let memory: String
    let chipset: String
    let id: String
    
    enum CodingKeys: String, CodingKey{
        
        case rating = "ratings"
        case name = "name"
        case series = "series"
        case price = "price"
        case coreClock = "core-clock"
        case memory = "memory"
        case chipset = "chipset"
        case id = "id"
    }
    
    func toTitle() -> String {
        return name.split(separator: " ")[0] + " " + series + " " + chipset
    }
    
    func toDesc() -> String {
        return ""
    }
}
