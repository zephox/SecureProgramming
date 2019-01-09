//
//  CPUController.swift
//  test
//
//  Created by Alex Iakab on 14/12/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import UIKit
import Alamofire

class MemoryController: UITableViewController {
    var itemArray = [Memory]()
    var cleanedArray = [Memory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(URL.Memory).responseObject { (response: DataResponse<Memorys>) in
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
}
extension MemoryController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cleanedArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        cell.textLabel?.text = cleanedArray[indexPath.row].name + " " + cleanedArray[indexPath.row].size
        cell.detailTextLabel?.text = cleanedArray[indexPath.row].price
        return cell
        
    }
}
