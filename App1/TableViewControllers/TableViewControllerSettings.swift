//
//  TableViewControllerSettings.swift
//  App1
//
//  Created by Robin on 15/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit

class TableViewControllerSettings: UITableViewController {
    var salary = 0.0
    var firstH = 0, firstM = 0, lastH = 0, lastM = 0
    var firstMString = "", lastMString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reLoadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func loadData() {
        let defaults = UserDefaults.standard
        salary = defaults.double(forKey: "salary")
        if let dict = defaults.dictionary(forKey: "timeDictionary"){
            if let startH = dict["startTime"], let startM = dict["startMinute"], let endH = dict["endTime"], let endM = dict["endMinute"] {
                firstH = startH as! Int
                firstM = startM as! Int
                lastH = endH as! Int
                lastM = endM as! Int
            }
        }
    }
    
    @objc func reLoadList(){
        //load data here
        salary = 0.0
        firstH = 0; firstM = 0; lastH = 0; lastM = 0
        firstMString = ""; lastMString = ""
        loadData()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellSalary = tableView.dequeueReusableCell(withIdentifier: "cellWithSalary", for: indexPath)
        let cellTime = tableView.dequeueReusableCell(withIdentifier: "cellWithWorkTime", for: indexPath)
        
        if (firstM <= 9){
            firstMString = "0" + String(firstM)
        }else{
            firstMString = String(firstM)
        };if (lastM <= 9){
            lastMString = "0" + String(lastM)
        }else {
            lastMString = String(lastM)
        }
        
        if let monthSalary = cellSalary.contentView.viewWithTag(10) as? UILabel {
            monthSalary.text = String(Int(salary))
        }; if let workTimeH = cellTime.contentView.viewWithTag(30) as? UILabel {
            workTimeH.text = String(firstH) + ":" + firstMString
        }; if let workTimeM = cellTime.contentView.viewWithTag(40) as? UILabel {
            workTimeM.text = String(lastH) + ":" + lastMString
        }
        
        
        if (indexPath.row == 0 ){
            return cellSalary
            
        }else {
            return cellTime
            
        }

        
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
