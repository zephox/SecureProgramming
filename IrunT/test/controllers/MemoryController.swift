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
    func showSimpleAlert(_ item: Memory) {
        let alert = UIAlertController(title: item.name, message:item.size + " " + item.speed,preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Add to Build",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        sharedInstance.shared.localBuild?.ram = item
        }))
        self.present(alert, animated: true, completion: nil)
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showSimpleAlert(cleanedArray[indexPath.row])
        
    }
}
