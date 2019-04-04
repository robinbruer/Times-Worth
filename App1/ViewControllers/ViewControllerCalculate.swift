//
//  ViewControllerCalculate.swift
//  App1
//
//  Created by Robin on 15/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit

class ViewControllerCalculate: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var arrayRatesKeys = [String]()
    var ratesDict = Dictionary<String, Any>()
    
    var indexForArray = 0
    var arrayRates = [String]()
    var dictRates = Dictionary<String, Any>()
    var ratesKey = ""
    var sek = 0.0
    let timeleft = DateHandler()
    
    @IBOutlet weak var calculateTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var displayHoursLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func calculatebtn(_ sender: Any) {
        loadDataRates()
        if let price = calculateTextField.text {
            if var douPrice = Double(price){
                if(sek > 0){
                    douPrice = douPrice * sek
                }
                let calculation = CalculateHours()
                let defaults = UserDefaults.standard
                let salary = defaults.double(forKey: "salary")
                if salary > 0 {
                    let result = Double(calculation.priceInHoursAvarge(montlySalary: salary, minutes: timeleft.workTime, price: douPrice, days: timeleft.oneWeek))
                    
                    displayHoursLabel.text = calculation.StringFromHours(minutes: result)
                }else{
                    displayHoursLabel.text = "Välj din lön först!"
                }
                
            }else {
                displayHoursLabel.text = "Fel inmatning"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadDataRates()
        bakground()
        roundButtons()
        pickerView.selectRow(indexForArray, inComponent: 0, animated: true)
        
        
        let defaults = UserDefaults.standard
        if let daysArray = defaults.dictionary(forKey: "dictArray"), let dict = defaults.dictionary(forKey: "timeDictionary"){
            timeleft.workTimeFromDict(dict: dict, arrayDict: daysArray)

        }
        
        
        
    }
    
    func roundButtons(){
        button.layer.cornerRadius = 5
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
    
    func loadDataRates(){
        let defaults = UserDefaults.standard
        arrayRates = defaults.array(forKey: "savedArrayRates") as! [String]
        if let findIndex = arrayRates.firstIndex(of: "SEK") {
            indexForArray = findIndex
        }
        if let dict = defaults.dictionary(forKey: "rates"){
            dictRates = dict
            for (key, value) in dict {
                print(key, value)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrayRates[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayRates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ratesKey = arrayRates[row]
        parseURL(theURL: "https://api.exchangeratesapi.io/latest?base=\(ratesKey)")
    }
    
    func parseURL (theURL: String) {
        let url = URL(string: theURL)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                //print("Error ", error)
            } else {
                do {
                    let parseData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    self.arrayRatesKeys.removeAll()
                    let defaults = UserDefaults.standard
                    for (key, value) in parseData {
                        
                        if (key == "rates"){
                            if let dict:[String:Any] = value as? [String:Any] {
                                self.ratesDict = dict
                                print(key, value)
                                for (key, value) in self.ratesDict {
                                    if (key == "SEK"){
                                        if let validate = value as? Double{
                                            self.sek = validate
                                                print(self.sek)
                                        }
                                    }
                                    self.arrayRatesKeys.append(key)
                                    defaults.set(self.arrayRatesKeys, forKey: "savedArrayRates")
                                }
                            }
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            
            } .resume()
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
