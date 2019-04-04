//
//  ViewControllerSaveProduct.swift
//  App1
//
//  Created by Robin on 15/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit

class ViewControllerSaveProduct: UIViewController, UITextFieldDelegate {
    var productsArray = [Product]()
    let timeLeft = DateHandler()
    

    @IBOutlet weak var produktNameTextField: UITextField!
    
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var produktPriceTextField: UITextField!
    
    @IBAction func saveProductBtn(_ sender: Any) {
        //let productPrice:Double? = Double(produktPriceTextField.text!)
        let newProduct = Product(name: produktNameTextField.text!, price: produktPriceTextField.text!, time: String(timeLeft.totalTime))
        productsArray.append(newProduct)
        saved()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        bakground()
        roundButtons()
        let defaults = UserDefaults.standard
        if let daysArray = defaults.dictionary(forKey: "dictArray"), let dict = defaults.dictionary(forKey: "timeDictionary"){
            timeLeft.workTimeFromDict(dict: dict, arrayDict: daysArray)
        }
        
        
        produktPriceTextField.delegate = self
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
    
    func saved() {
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
