//
//  nextViewController.swift
//  test
//
//  Created by Alex Iakab on 29/11/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import UIKit
import Alamofire

class CaseController: UITableViewController {
    var itemArray = [Case]()
    var cleanedArray = [Case]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(URL.Case).responseObject { (response: DataResponse<Cases>) in
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
    
    func showSimpleAlert(_ item: Case) {
        let alert = UIAlertController(title: item.name, message:item.name + " " + item.price ,preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Add to Build",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        sharedInstance.shared.kast = item
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        cell.textLabel?.text = cleanedArray[indexPath.row].name + " " + cleanedArray[indexPath.row].price
        cell.detailTextLabel?.text = cleanedArray[indexPath.row].price
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showSimpleAlert(cleanedArray[indexPath.row])
    }
}
