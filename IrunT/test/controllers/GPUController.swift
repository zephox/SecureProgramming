//
//  nextViewController.swift
//  test
//
//  Created by Alex Iakab on 29/11/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import UIKit
import Alamofire

class GPUController: UITableViewController {
    var itemArray = [GPU]()
    var cleanedArray = [GPU]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(URL.GPU).responseObject { (response: DataResponse<GPUS>) in
            if let gpuArray = response.value{
                self.itemArray = gpuArray
                    for a in self.itemArray{
                        if a.price != ""{
                            self.cleanedArray.append(a)
                        }
                    }
                    self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cleanedArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath) as! tvc
        cell.textLabel?.text = cleanedArray[indexPath.row].name.split(separator: " ")[0] + " " + cleanedArray[indexPath.row].series + " " + cleanedArray[indexPath.row].chipset
        cell.detailTextLabel?.text = cleanedArray[indexPath.row].price
        return cell
        
    }
}