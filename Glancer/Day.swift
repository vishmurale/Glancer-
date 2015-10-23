//
//  Day.swift
//  Glancer
//
//  Created by Vishnu Murale on 5/15/15.
//  Copyright (c) 2015 Vishnu Murale. All rights reserved.
//

import Foundation


public class Day: NSObject {
    
    var name: String = "";
    var time_to_block = [NSDate: String]()
    var ordered_blocks = [String]();
    var ordered_times = [String]();
    
    var messages_forBlock = [String : String]();
    
    
    init(name: String){
        self.name = name;
    }
    
    func getDate_AsString() -> String{
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Month, .Year, .Day], fromDate: date)
        
        let month = components.month
        let year = components.year
        let day = components.day
        
        var month_string = String(month)
        if(month_string.characters.count == 1){
            
            month_string = "0" + month_string
        }
        
        
        var out_date = String(year) + "-"
        out_date += month_string
        out_date += "-" + String(day)
        
        return out_date
        
    }
    
    func refreshDay(block_order: Array<String>, times: Array<String>){
        for index in 0...(times.count-1){
            
            ordered_blocks.append(block_order[index]);
            ordered_times.append(times[index]);
            print(self.name, terminator: "")
            let block = block_order[index]
            print("Block: "+block+" ", terminator: "")
            let time = times[index]
            print("Timer: "+time+" ", terminator: "")
            let timerDate = timeToNSDate(time)
            print("NSDate ", terminator: "")
            print(timerDate)
            time_to_block[timerDate] = block
        }
        
    }
    
    func timeToNSDate(time: String)->NSDate {
        var currentDate = getDate_AsString()
        let formatter  = NSDateFormatter()
        formatter.timeZone = NSTimeZone.localTimeZone()
        formatter.dateFormat = "yyyy-MM-dd-HH-mm"
        currentDate+=time;
        let outDate = formatter.dateFromString(currentDate)!
        return outDate;
    }
    
    
    func NSDateToString(time: NSDate)->String {
        
        
        
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone.localTimeZone()
        let components = calendar.components([.Month, .Year, .Day, .Hour, .Minute], fromDate: time)
        
        let month = components.month
        let year = components.year
        let day = components.day
        let hour = components.hour
        
        let minute = components.minute
        
        var month_string = String(month)
        if(month_string.characters.count == 1){
            
            month_string = "0" + month_string
        }
        var hour_string = String(hour)
        if(hour_string.characters.count == 1){
            
            hour_string = "0" + hour_string
        }
        var minute_string = String(minute)
        if(minute_string.characters.count == 1){
            
            minute_string = "0" + minute_string
        }
        
        
        var out_date = String(year) + "-"
        out_date += month_string
        out_date += "-" + String(day)
        out_date += "-" + hour_string
        out_date += "-" + minute_string
        
        return out_date
        
    }
    
    
    func NSDateToStringWidget(time: NSDate)->String {
        
        
        
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone.localTimeZone()
        let components = calendar.components([.Month, .Year, .Day, .Hour, .Minute], fromDate: time)
        
        let month = components.month

        let hour = components.hour
        
        let minute = components.minute
        
        var month_string = String(month)
        if(month_string.characters.count == 1){
            
            month_string = "0" + month_string
        }
        var hour_string = String(hour)
        if(hour_string.characters.count == 1){
            
            hour_string = "0" + hour_string
        }
        var minute_string = String(minute)
        if(minute_string.characters.count == 1){
            
            minute_string = "0" + minute_string
        }
        
        var out_date = "-"
        out_date += hour_string
        out_date += "-" + minute_string
        
        return out_date
        
    }

    
    func getDayOfWeek_fromString(today:String)->Int {
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.dateFromString(today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
        var weekDay = myComponents.weekday
        
        if(weekDay == 1){
            weekDay = 6
        }
        else{
            weekDay = weekDay - 2;
        }
        
        return weekDay
    }
    
}