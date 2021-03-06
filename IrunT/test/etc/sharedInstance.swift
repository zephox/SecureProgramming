//
//  sharedInstance.swift
//  test
//
//  Created by Alex Iakab on 13/01/2019.
//  Copyright © 2019 Alex Iakab. All rights reserved.
//

import Foundation

class sharedInstance{
    //singleton
    static let shared = sharedInstance()
    var localBuild: build?
    var gpu : GPU?
    var cpu : CPU?
    var ram : Memory?
    var psu : PSU?
    var kast : Case?
    
    func toBuildString() -> String{
        return "cpu: " + cpu!.name + " " +
            "gpu: " + gpu!.name + " " +
            "ram: " + ram!.size + " "
    }
    
    //TODO: save whole as struct
    func saveBuild() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(sharedInstance.shared.ram), forKey:"memory")
        UserDefaults.standard.set(try? PropertyListEncoder().encode(sharedInstance.shared.gpu), forKey:"gpu")
        UserDefaults.standard.set(try? PropertyListEncoder().encode(sharedInstance.shared.cpu), forKey:"cpu")
        UserDefaults.standard.set(try? PropertyListEncoder().encode(sharedInstance.shared.psu), forKey:"psu")
         UserDefaults.standard.set(try? PropertyListEncoder().encode(sharedInstance.shared.kast), forKey:"case")
    }
    //TODO: load whole as struct
    func loadBuild(){
        if let data = UserDefaults.standard.value(forKey:"memory") as? Data {
            sharedInstance.shared.ram = try? PropertyListDecoder().decode(Memory.self, from: data)
        }
        if let data = UserDefaults.standard.value(forKey:"gpu") as? Data {
            sharedInstance.shared.gpu = try? PropertyListDecoder().decode(GPU.self, from: data)
        }
        if let data = UserDefaults.standard.value(forKey:"cpu") as? Data {
            sharedInstance.shared.cpu = try? PropertyListDecoder().decode(CPU.self, from: data)
        }
        if let data = UserDefaults.standard.value(forKey:"psu") as? Data {
            sharedInstance.shared.psu = try? PropertyListDecoder().decode(PSU.self, from: data)
        }
        if let data = UserDefaults.standard.value(forKey:"case") as? Data {
            sharedInstance.shared.kast = try? PropertyListDecoder().decode(Case.self, from: data)
        }
    }
    //Initializer access level change now
    private init(){}
}
