//
//  ViewControllerWorkingTime.swift
//  App1
//
//  Created by Robin on 21/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit

class ViewControllerWorkingTime: UIViewController, UITextFieldDelegate {
    
    var daysArray = [Int]()

    @IBOutlet weak var startTimeTextField: UITextField!
    
    @IBOutlet weak var startMinuteTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var endMinuteTextField: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var mondaySwitch: UISwitch!
    @IBOutlet weak var tuesdaySwith: UISwitch!
    @IBOutlet weak var wednesdaySwitch: UISwitch!
    @IBOutlet weak var thursdaySwitch: UISwitch!
    @IBOutlet weak var fridaySwitch: UISwitch!
    @IBOutlet weak var saturdaySwitch: UISwitch!
    @IBOutlet weak var sundaySwitch: UISwitch!
    
    var lunchBreak = false
    @IBAction func checkboxLunch(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            lunchBreak = false
        }else {
            sender.isSelected = true
            lunchBreak = true
        }
        
    }
    
    
    
    @IBAction func saveTimebtn(_ sender: Any) {
        chechDays()
        if let startTime = startTimeTextField.text, let endTime = endTimeTextField.text, let startMinute = startMinuteTextField.text, let endMinute = endMinuteTextField.text{
            let defaults = UserDefaults.standard
            
            defaults.set(lunchBreak, forKey: "lunchBreak")
            // TODO: Fixa så andvändaren kan välja arbetsdagar som läggs i arrayn
            
            if let savedValue = defaults.dictionary(forKey: "timeDictionary"){
                
                if let year = savedValue["year"], let month = savedValue["month"], let day = savedValue["day"] {
                    let timeDict = ["startTime": Int(startTime)!, "startMinute": Int(startMinute)!, "endTime": Int(endTime)!, "endMinute": Int(endMinute)!, "year": year, "month": month, "day": day]
                    let dictArray = ["daysArray": daysArray]
                    defaults.set(timeDict, forKey: "timeDictionary")
                    defaults.set(dictArray, forKey: "dictArray")
                }
            }else {
                let year = Calendar.current.component(.year, from: Date())
                let month = Calendar.current.component(.month, from: Date())
                let day = Calendar.current.component(.day, from: Date())
                let timeDict = ["startTime": Int(startTime), "startMinute": Int(startMinute), "endTime": Int(endTime), "endMinute": Int(endMinute), "year": year, "month": month, "day": day]
                let dictArray = ["daysArray": daysArray]
                defaults.set(timeDict, forKey: "timeDictionary")
                defaults.set(dictArray, forKey: "dictArray")
            }
            let savedTime = 0
            defaults.set(savedTime, forKey: "timeLef")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        self.navigationController?.popViewController(animated: true)
}
        
    override func viewDidLoad() {
        super.viewDidLoad()
        bakground()
        roundButtons()
        self.startTimeTextField.delegate = self
        self.startMinuteTextField.delegate = self
        self.endTimeTextField.delegate = self
        self.endMinuteTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func roundButtons(){
        saveBtn.layer.cornerRadius = 5
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
    
    func chechDays() {
        if sundaySwitch.isOn {
            daysArray.append(1)
        }; if mondaySwitch.isOn {
            daysArray.append(2)
        }; if tuesdaySwith.isOn {
            daysArray.append(3)
        }; if wednesdaySwitch.isOn {
            daysArray.append(4)
        }; if thursdaySwitch.isOn {
            daysArray.append(5)
        }; if fridaySwitch.isOn {
            daysArray.append(6)
        }; if saturdaySwitch.isOn {
            daysArray.append(7)
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
