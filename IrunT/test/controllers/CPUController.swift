
import UIKit
import Alamofire

class CPUController: UITableViewController {
    var itemArray = [CPU]()
    var cleanedArray = [CPU]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(URL.CPU).responseObject { (response: DataResponse<CPUS>) in
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
    
    func showSimpleAlert(_ item: CPU) {
        let alert = UIAlertController(title: item.name, message:item.cores + " " + item.name + " " + item.price ,preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Add to Build",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        sharedInstance.shared.cpu = item
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
        cell.textLabel?.text = cleanedArray[indexPath.row].name.split(separator: " ")[0] + " " + cleanedArray[indexPath.row].speed + " " + cleanedArray[indexPath.row].cores + " Cores"
        cell.detailTextLabel?.text = cleanedArray[indexPath.row].price
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showSimpleAlert(cleanedArray[indexPath.row])
        
    }
}
