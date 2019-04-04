//
//  TableViewControllerSavedProducts.swift
//  App1
//
//  Created by Robin on 17/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit

class TableViewControllerSavedProducts: UITableViewController {
    var productsArray = [Product]()
    let timeleft = DateHandler()
    let calculation = CalculateHours()
    var salary = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        load()
//        let defaults = UserDefaults.standard
//        let daysArray = defaults.dictionary(forKey: "dictArray1")
//        let dict = defaults.dictionary(forKey: "timeDictionary1")
//        salary = defaults.double(forKey: "salary1")
//        
//        timeleft.workTimeFromDict(dict: dict!, arrayDict: daysArray!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reLoadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func reLoadList(){
        //load data here
    productsArray.removeAll()
    load()
    self.tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! productCellView

        let product = productsArray[indexPath.row]
        
        productCell.nameLabel.text = product.name
        productCell.priceLabel.text = product.price
        
        if let price = Double(product.price){
            if salary > 0 {
            calculation.priceInMinutesAvarege(montlySalary: salary, minutes: timeleft.workingMinutes, price: price, workedMinutes: timeleft.totalTime, days: timeleft.oneWeek)
            }else {
                productCell.timeLabel.text = "Välj din lön först!"
            }
        }
        if calculation.minutesLeft <= 0 {
            productCell.timeLabel.text = "Du har uppnått ditt sparmål!"
        } else {
            productCell.timeLabel.text = calculation.StrigFromMinutesToHour()
        }
        return productCell
    }
    
    func load() {
        let defaults = UserDefaults.standard
        if let daysArray = defaults.dictionary(forKey: "dictArray"), let dict = defaults.dictionary(forKey: "timeDictionary"){
            salary = defaults.double(forKey: "salary")
            timeleft.workTimeFromDict(dict: dict, arrayDict: daysArray)
        }
        
        if let prodArray = defaults.array(forKey: "productList"){
            for dict in prodArray{
                let newProd = Product(data: dict as! Dictionary<String, String>)
                productsArray.append(newProd)
            }
        }
    }
    
    func save() {
        var saveArray = [Dictionary<String, String>]()
        for product in productsArray {
            let dict = product.productDictionary()
            saveArray.append(dict)
        }
        let defaults = UserDefaults.standard
        defaults.set(saveArray, forKey: "productList")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "removeSegue" {
            if let ViewControllerRemove = segue.destination as? ViewControllerRemoveProduct {
                if let indexPath = self.tableView.indexPathForSelectedRow{
                    let newProd = productsArray[indexPath.row]
                    ViewControllerRemove.product = productsArray[indexPath.row]
                    ViewControllerRemove.indexInArray = indexPath.row
                    if let price = Double(newProd.price){
                        calculation.priceInMinutesAvarege(montlySalary: salary, minutes: timeleft.workTime, price: price, workedMinutes: timeleft.totalTime, days: timeleft.oneWeek)
                    }
                    if calculation.minutesLeft <= 0 {
                        ViewControllerRemove.timeLeftString = "Du har uppnått ditt sparmål!"
                    } else {
                        ViewControllerRemove.timeLeftString = calculation.StrigFromMinutesToHour()
                    }
            }
        }
        
    }
    

}
}
