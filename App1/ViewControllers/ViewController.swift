//
//  ViewController.swift
//  App1
//
//  Created by Robin on 10/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit
import UserNotifications




class ViewController: UIViewController {
    var productsArray = [Product]()

    @IBOutlet weak var listProductsBtn: UIButton!
    @IBOutlet weak var calculatebtn: UIButton!
    @IBOutlet weak var saveProduktBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    
    
    var arrayRatesKeys = [String]()
    var ratesDict = Dictionary<String, Any>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bakground()
        load()
        roundButtons()
        sendNotification()
        
    }
    
    func roundButtons(){
        listProductsBtn.layer.cornerRadius = 5
        calculatebtn.layer.cornerRadius = 5
        saveProduktBtn.layer.cornerRadius = 5
        settingsBtn.layer.cornerRadius = 5
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
    
    func sendNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        
        content.title = "Times Worth"
        //content.subtitle = "Välkommen"
        content.body = "För en bättre koll på vad tiden är värd"
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "local-notificatons temp"
        
        let date = Date(timeIntervalSinceNow: 20)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if error != nil {
                //print(error)
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
    
    func load() {
        let defaults = UserDefaults.standard
        if let prodArray = defaults.array(forKey: "productList"){
            for dict in prodArray{
                let newProd = Product(data: dict as! Dictionary<String, String>)
                productsArray.append(newProd)
            }
        }
        
        
    }


}

