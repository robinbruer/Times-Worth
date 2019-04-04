//
//  ViewControllerRemoveProduct.swift
//  App1
//
//  Created by Robin on 25/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit

class ViewControllerRemoveProduct: UIViewController {

    var productsArray = [Product]()
    var product = Product()
    var timeLeftString = ""
    let timeleft = DateHandler()
    var indexInArray = 0
    let calculation = CalculateHours()
    var time = 0
    
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var payed: UIButton!
    
    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "Radera vara", message: "Varan raderas ur listan", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
        self.productsArray.remove(at: self.indexInArray)
        self.save()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        self.navigationController?.popViewController(animated: true)
            }))
        alert.addAction(UIAlertAction(title: "Avbryt", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func paidProduktBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Köpt vara", message: "Varan tas bort och den arbetade tiden nollställs", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
        self.productsArray.remove(at: self.indexInArray)
        let defaults = UserDefaults.standard
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        let date = Date()
        let calender = Calendar.current
        let dict = defaults.dictionary(forKey: "timeDictionary")
        if let startTime = dict?["startTime"], let startMinute = dict?["startMinute"], let endTime = dict?["endTime"], let endMinute = dict?["endMinute"]{
            let startDatum = DateComponents(year: year, month: month, day: day, hour: startTime as? Int, minute: startMinute as? Int)
            
            let start = calender.date(from: startDatum)
          
            let compareTime = calender.dateComponents([.minute], from: start!, to: date)
            
            
            if let minutes = compareTime.minute{
                let dayOfMinutes = defaults.integer(forKey: "workingMinutes")
                self.time = minutes
                print(minutes)
                if minutes > dayOfMinutes {
                    self.time = dayOfMinutes
                    print(minutes)
                }
                
                print("Time Left from view Controller", self.time)
                defaults.set(self.time, forKey: "timeLef")
                    if let startH = startTime as? Int, let startM = startMinute as? Int, let endH = endTime as? Int, let endM = endMinute as? Int{
                        let timeDict = ["startTime": startH, "startMinute": startM, "endTime": endH, "endMinute": endM, "year": year, "month": month, "day": day]
                        defaults.set(timeDict, forKey: "timeDictionary")
                        self.save()
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                        self.navigationController?.popToRootViewController(animated: true)
                }
            print(compareTime)
                
                
        }
        }
          }))
        
        alert.addAction(UIAlertAction(title: "Avbryt", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bakground()
        load()
        roundButtons()
        nameLabel.text = product.name
        priceLabel.text = product.price
        timeLabel.text = timeLeftString
        
        
    }
    
    func roundButtons(){
        payed.layer.cornerRadius = 5
        delete.layer.cornerRadius = 5
    }

    
    func load() {
        let defaults = UserDefaults.standard
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
    
    func bakground () {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bakground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "bakgroundLandscape")
            backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)
            
        } else {
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "bakground")
            backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
