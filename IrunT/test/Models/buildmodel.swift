//
//  buildmodel.swift
//  test
//
//  Created by Alex Iakab on 13/01/2019.
//  Copyright © 2019 Alex Iakab. All rights reserved.
//

import Foundation

struct build : Codable {
    var psu : PSU
    var gpu : GPU
    var cpu : CPU
    var ram : Memory
}
