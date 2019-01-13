//
//  buildmodel.swift
//  test
//
//  Created by Alex Iakab on 13/01/2019.
//  Copyright © 2019 Alex Iakab. All rights reserved.
//

import Foundation

class build : Codable {
    public var psu : PSU
    public var gpu : GPU
    public var cpu : CPU
    public var ram : Memory
}
