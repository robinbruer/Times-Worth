//
//  ViewControllerEnterSalary.swift
//  App1
//
//  Created by Robin on 15/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit

class ViewControllerEnterSalary: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var SalaryTextField: UITextField!
    
    @IBOutlet weak var save: UIButton!
    @IBAction func editSalaryBtn(_ sender: Any) {
        if let salary = SalaryTextField.text {
            let defaults = UserDefaults.standard
            defaults.set(Double(salary), forKey: "salary")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bakground()
        roundButtons()
        self.SalaryTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func roundButtons(){
        save.layer.cornerRadius = 5
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
