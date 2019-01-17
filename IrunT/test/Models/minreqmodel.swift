//
//  minreqmodel.swift
//  test
//
//  Created by Alex Iakab on 18/01/2019.
//  Copyright © 2019 Alex Iakab. All rights reserved.
//

import Foundation

struct minreq: Codable, Hashable {
    let gID: String
    let name: String
    let cpuIntel: String
    let cpuAMD: String
    let memory: String
    let gpuNvidia: String
    let gpuAMD: String
    
    enum CodingKeys: String, CodingKey {
        case gID = "g_id"
        case name = "name"
        case cpuIntel = "cpu_intel"
        case cpuAMD = "cpu_amd"
        case memory = "memory"
        case gpuNvidia = "gpu_nvidia"
        case gpuAMD = "gpu_amd"
    }
}
