//
//  gamemodel.swift
//  test
//
//  Created by Alex Iakab on 16/01/2019.
//  Copyright © 2019 Alex Iakab. All rights reserved.
//

import Foundation

typealias Games = [Game]

struct Game: Codable, Hashable {
    let gID: String
    let gTitle: String
    
    enum CodingKeys: String, CodingKey {
        case gID = "g_id"
        case gTitle = "g_title"
    }
}
