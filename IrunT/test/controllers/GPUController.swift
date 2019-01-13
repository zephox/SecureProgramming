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
    
    func showSimpleAlert(_ item: GPU) {
        let alert = UIAlertController(title: item.name, message:item.series + " " + item.name + " " + item.price ,preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Add to Build",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        sharedInstance.shared.gpu = item
                                        sharedInstance.shared.saveBuild()
        }))
        self.present(alert, animated: true, completion: nil)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showSimpleAlert(cleanedArray[indexPath.row])
        
    }
}
