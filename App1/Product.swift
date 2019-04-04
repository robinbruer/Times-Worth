//
//  Product.swift
//  App1
//
//  Created by Robin on 17/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit

class Product {
    var name: String
    var price: String
    var timeLeft: String
    
    init(name: String, price: String, time: String) {
        self.name = name
        self.price = price
        self.timeLeft = time
    }
    
    init(data: Dictionary<String, String>) {
        if let name = data["name"], let price = data["price"], let time = data["time"]{
            self.name = name
            self.price = price
            self.timeLeft = time
        }else {
            self.name = ""
            self.price = ""
            self.timeLeft = ""
        }
    }
    
    convenience init() {
        self.init(name: "No name", price: "No price", time: "")
    }
    
    func productDictionary() -> Dictionary<String, String> {
        return ["name": self.name, "price": self.price, "time": self.timeLeft]
    }
    
   
    

}
