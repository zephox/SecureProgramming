//
//  GameViewController.swift
//  test
//
//  Created by Alex Iakab on 16/01/2019.
//  Copyright © 2019 Alex Iakab. All rights reserved.
//

import UIKit
import Alamofire

class GameViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var gameArray = [Game]()
    var searchArray = [Game]()
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchbutton: UIButton!
    @IBOutlet weak var searchbar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        Alamofire.request(URL.GameList).responseObject { (response: DataResponse<Games>) in
            if let gamearray = response.value{
                self.gameArray = gamearray
                //self.searchArray = gamearray
                self.tableview.reloadData()
            }
        }
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchArray.removeAll()
        for item in gameArray{
            if item.gTitle.lowercased().contains(searchbar.text!.lowercased()){
                searchArray.append(item);
            }
        }
        if searchbar.text == "" {
            searchArray.removeAll()
        }
        tableview.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchArray.count > 0 {
            return searchArray.count
        }
        else{
            return gameArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        if searchArray.count > 0{
            cell.textLabel?.text = searchArray[indexPath.row].gTitle
        }
        else{
            cell.textLabel?.text = gameArray[indexPath.row].gTitle
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchArray.count > 0 {
            getRequirements(searchArray[indexPath.row].gID)
        }
        else{
             getRequirements(gameArray[indexPath.row].gID)
        }
    }
    
    func getRequirements(_ gameID : String){
        Alamofire.request(URL.GameStats + gameID).responseObject { (response: DataResponse<minreq>) in
            if let resp = response.value{
               print(resp)
            }
        }
    }
}
