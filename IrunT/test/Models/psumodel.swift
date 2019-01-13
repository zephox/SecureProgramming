//
//  psumodel.swift
//  test
//
//  Created by Alex Iakab on 13/01/2019.
//  Copyright © 2019 Alex Iakab. All rights reserved.
//

import Foundation

typealias PSUS = [PSU]

struct PSU: Codable, Hashable {
    let ratings: String
    let watts: String
    let name: String
    let form: String
    let efficiency: String
    let series: String
    let price: String
    let modular: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case ratings = "ratings"
        case watts = "watts"
        case name = "name"
        case form = "form"
        case efficiency = "efficiency"
        case series = "series"
        case price = "price"
        case modular = "modular"
        case id = "id"
    }
}

