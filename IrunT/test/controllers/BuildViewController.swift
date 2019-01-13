//
//  BuildViewController.swift
//  test
//
//  Created by Alex Iakab on 13/01/2019.
//  Copyright © 2019 Alex Iakab. All rights reserved.
//

import UIKit
import Foundation

class BuildViewController: UIViewController{
    @IBOutlet weak var cpuLabel: UILabel!
    @IBOutlet weak var gpuLabel: UILabel!
    @IBOutlet weak var ramLabele: UILabel!
    @IBOutlet weak var psuLabel: UILabel!
    @IBOutlet weak var moboLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sharedInstance.shared.loadBuild()
        cpuLabel.text = sharedInstance.shared.cpu?.name
        ramLabele.text = sharedInstance.shared.ram?.name
        gpuLabel.text = sharedInstance.shared.gpu?.name
        psuLabel.text = sharedInstance.shared.psu?.name
    }
}
