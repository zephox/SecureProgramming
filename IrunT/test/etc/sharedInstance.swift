//
//  sharedInstance.swift
//  test
//
//  Created by Alex Iakab on 13/01/2019.
//  Copyright © 2019 Alex Iakab. All rights reserved.
//

class sharedInstance{
    
    static let shared = sharedInstance()
    
    var localBuild: build?
    //Initializer access level change now
    private init(){}
    
    
}
