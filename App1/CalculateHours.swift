//
//  CalculateHours.swift
//  App1
//
//  Created by Robin on 10/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit

class CalculateHours {
    var minutesLeft =  0.0
    

    
    
    func priceInMinutesAvarege (montlySalary: Double, minutes: Int, price: Double, workedMinutes: Int, days: [Int]) {
        let daysOfWeek = days.count
        let minutesPerWeek = daysOfWeek * minutes
        let salaryPerMinute = ((montlySalary) * 12.0) / (52.0 * Double(minutesPerWeek))
        minutesLeft = price / Double(salaryPerMinute) - Double(workedMinutes)
    }
    
    
    func priceInHoursAvarge (montlySalary: Double, minutes: Int, price: Double, days: [Int]) -> Double{
   
        let daysOfWeek = days.count
        let minutesPerWeek = daysOfWeek * minutes
        let salaryPerMinute = ((montlySalary) * 12.0) / (52.0 * Double(minutesPerWeek))
                
        return price / Double(salaryPerMinute)
    }
    
    func StrigFromMinutesToHour() -> String{
        
        
        let hours = minutesLeft / 60
        let intHours = Int(hours)
        let getMinutes = hours - Double(intHours)
        let minutes = getMinutes * 60
        
        
        
        return String(Int(hours)) + " h och " + String(Int(minutes)) + " min"
    }
    
    func StringFromHours(minutes: Double) -> String{
        let hours = minutes / 60
        let intHours = Int(hours)
        let getMinutes = hours - Double(intHours)
        let minutes = getMinutes * 60
        
        return String(Int(hours)) + " h och " + String(Int(minutes)) + " min"
    }

}
