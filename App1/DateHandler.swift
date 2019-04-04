//
//  DateHandler.swift
//  App1
//
//  Created by Robin on 21/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit

class DateHandler {
    let date = Date()
    let calender = Calendar.current
    let currentyear = Calendar.current.component(.year, from: Date())
    let currentmonth = Calendar.current.component(.month, from: Date())
    let currentday = Calendar.current.component(.day, from: Date())
    var totalTime = 0
    var workingMinutes = 0
    var workTime = 0
    var totalDays = 0
    var arrayWithDays = [Int]()
    var totalDayArray = [Int]()
    var lunchBreak = false
    var oneWeek = [Int]()
    
    
    func workHours (startH: Int, startM: Int, slutH: Int, slutM: Int, year: Int, month: Int, day: Int, weekDay: [Int]){
        let defaults = UserDefaults.standard
        let lunchBreak = defaults.bool(forKey: "lunchBreak")
        var slutHN = 0
        if lunchBreak == true  {
            if slutH > 0 {
                slutHN = slutH - 1
            } else {
                slutHN = 23
            }
        }else {
            slutHN = slutH
        }
        let currentyear = Calendar.current.component(.year, from: Date())
        let currentmonth = Calendar.current.component(.month, from: Date())
        let currentday = Calendar.current.component(.day, from: Date())
        
        let startDatum = DateComponents(year: year, month: month, day: day, hour: startH, minute: startM)

        var slutDatum = DateComponents(year: year, month: month, day: day, hour: slutHN, minute: slutM)
        var chechDatum = DateComponents(year: currentyear, month: currentmonth, day: currentday, hour: slutH, minute: slutM)
        let chechStartDatum = DateComponents(year: currentyear, month: currentmonth, day: currentday, hour: startH, minute: startM)
        
        if slutHN >= 24 {
            let timme = slutHN - 24
            slutDatum = DateComponents(year: year, month: month, day: day+1, hour: timme, minute: slutM)
            chechDatum = DateComponents(year: currentyear, month: currentmonth, day: currentday+1, hour: slutH, minute: slutM)
        }; if slutHN < startH {
            slutDatum = DateComponents(year: year, month: month, day: day+1, hour: slutHN, minute: slutM)
            chechDatum = DateComponents(year: currentyear, month: currentmonth, day: currentday+1, hour: slutH, minute: slutM)
        }else {
            slutDatum = DateComponents(year: year, month: month, day: day, hour: slutHN, minute: slutM)
            chechDatum = DateComponents(year: currentyear, month: currentmonth, day: currentday, hour: slutH, minute: slutM)
        }
        let start = calender.date(from: startDatum)
        let slut = calender.date(from: slutDatum)
        let today = calender.date(from: chechDatum)
        let todayStart = calender.date(from: chechStartDatum)
        let compareTime = calender.dateComponents([.minute], from: start!, to: slut!)
        let numberofdays = calender.dateComponents([.day], from: start!, to: date)
        let chechIfWork = calender.dateComponents([.minute], from: date, to: today!)
        let numberofminutes = calender.dateComponents([.minute], from: todayStart!, to: date)
        
        let dayOfWeek = calender.component(.weekday, from: date)
        
        if let days = numberofdays.day{
            for i in 0..<days{
                let newdate = DateComponents(year: year, month: month, day: day+i, hour: startH, minute: startM)
                let start2 = calender.date(from: newdate)
                let dayOfWeek2 = calender.component(.weekday, from: start2!)
                arrayWithDays.append(dayOfWeek2)
            };
            let counts = arrayWithDays.reduce(into: [:]) { counts, word in counts[word, default: 0] += 1 }
            
            for test in 0..<weekDay.count{
                if let dayKey = counts[weekDay[test]]{
                    totalDays = totalDays + dayKey
                }
            }
            
            if let minutes = compareTime.minute{
                workingMinutes = minutes
                workTime = minutes
            }
            totalTime = workingMinutes * totalDays
            
        }
        if (weekDay.contains(dayOfWeek)){
            if let chech = chechIfWork.minute{
                
                if (chech > 0){
                    if let activedayM = numberofminutes.minute{
                        totalTime = totalTime + activedayM
                    }
                }else{
                    totalTime = totalTime + workingMinutes
                    
                }
            }
        }
         let savedTime = defaults.integer(forKey: "timeLef")
        
        totalTime = totalTime - savedTime
        defaults.set(workingMinutes, forKey: "workingMinutes")
        oneWeek = weekDay
    }
    
    func workTimeFromDict(dict: Dictionary<String, Any>, arrayDict: Dictionary<String, Any>) {
        if let startTime = dict["startTime"], let startMinute = dict["startMinute"], let endTime = dict["endTime"], let endMinute = dict["endMinute"], let year = dict["year"], let month = dict["month"], let day = dict["day"], let array = arrayDict["daysArray"]{
            workHours(startH: startTime as! Int, startM: startMinute as! Int, slutH: endTime as! Int, slutM: endMinute as! Int, year: year as! Int, month: month as! Int, day: day as! Int, weekDay: array as! [Int])
        }
    }
    
    
    
    
}
