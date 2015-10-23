//
//  TodayViewController.swift
//  WidgetExtention
//
//  Created by Vishnu Murale on 6/9/15.
//  Copyright (c) 2015 Vishnu Murale. All rights reserved.
//

import UIKit
import NotificationCenter
import Parse


class TodayViewController: UIViewController, NCWidgetProviding {
        

    let screenSize: CGRect = UIScreen.mainScreen().bounds
   



    let BlockOrder = ["A","B","C","D","E","F","G"]

   
    var Schedule = PFObject(className:"Schedule")
    let defaults = NSUserDefaults(suiteName:"group.vishnu.squad.widget")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let screenWidth = screenSize.width

        self.preferredContentSize = CGSizeMake(screenWidth, 300);
        
        
        
        Parse.setApplicationId("BPYBAkzK8Wa0LdozJpfRqnTVb14MTyi8XiQ1rhE8",
            clientKey: "YskOxJOe5iJcbQAfC3uuX7OgiSYzmIfb9DtrPx1y")

        
       self.update_widget()
      
       
    }
    
    
    func SetTextForOtherBlocks(Day_Num : Int, Days :[Day], firstLunch : Bool, User_Info : [String]) -> String{
        
        var text = "";
        
        for block in Days[Day_Num].ordered_blocks{
            
            var message = block;
            
            if(firstLunch && message.hasSuffix("1")){
                
                
                message = "Lunch"
                
                
                
            }
            else if(!firstLunch && message.hasSuffix("2")){
                
                message = "Lunch"
                
                
            }else{
                
                var counterDigit = 0;
                
                
                for i in message.characters{
                    
                    
                    if(message.characters.count > 2 && String(i) == "A" && counterDigit == 0){
                        counterDigit++;
                        message = "Act"
                        
                    }else{
                   
                    if(counterDigit == 0){
                        message = String(i)
                    }
                    counterDigit++;
                    }
                    
                }
                
                
                
                
                
                
            }
            
            
            if(self.BlockOrder.indexOf(message) != nil){
                
                let indexOfUserInfo = self.BlockOrder.indexOf(message)!
                
                if(User_Info[indexOfUserInfo] != ""){
                    message = User_Info[indexOfUserInfo]
                    
                }
                
                
                
                
            }
            
            
            
            
            text += message + " ";
            
            
        }

        
        return text;
        
        
        
    }
    
    func find_Minutes(hour_before : Int, hour_after : Int)->Int{
        
        var HOUR_AFTER_MINUS_FIVE = hour_after
        
        if(hour_after%100 < 5){
            
            HOUR_AFTER_MINUS_FIVE = hour_after - 5 - 40
            
        }
        else{
            HOUR_AFTER_MINUS_FIVE = hour_after - 5
        }
        
        
        
        let num_hours_less = Int(hour_before/100)
        let num_hours_more = Int(HOUR_AFTER_MINUS_FIVE/100)
        
        let diff_hours = num_hours_more-num_hours_less
        
        print("Diff in hours" + String(diff_hours))
        
        let diff_minutes = HOUR_AFTER_MINUS_FIVE%100 - hour_before%100
        
        print("Diff in minutes" + String(diff_minutes))
        
        
        return diff_hours*60 + diff_minutes;
        
        
    }

    


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func substring(origin :String, StartIndex : Int, EndIndex : Int)->String{
        var counter = 0
        var subString = ""
        for char in origin.characters{
            
            if(StartIndex <= counter && counter < EndIndex){
                subString += String(char)
            }
            
            counter++;
            
        }
        
        return subString
        
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        
        }
    
    
    func update_widget() -> Bool{
 
        
        
        
        let screenWidth = screenSize.width
        
        
        let Order_label = UILabel(frame: CGRectMake(0, 0, 500, 21))
        Order_label.center = CGPointMake(screenWidth/2-100/2, 284)
        Order_label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1);
        Order_label.adjustsFontSizeToFitWidth = true
        Order_label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(Order_label);

     
        let Time_Label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        Time_Label.center = CGPointMake(screenWidth/2-100/2, 200)
        Time_Label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1);
        Time_Label.textAlignment = NSTextAlignment.Center
        Time_Label.adjustsFontSizeToFitWidth = true
        self.view.addSubview(Time_Label);
        
        let Block_Label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        Block_Label.center = CGPointMake(screenWidth/2-100/2, 100)
        Block_Label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1);
        Block_Label.textAlignment = NSTextAlignment.Center
        Block_Label.adjustsFontSizeToFitWidth = true
        self.view.addSubview(Block_Label);

        
        var Success = false;
        
        var Days = [Day]()
        
        
        let query = PFQuery(className:"Schedule")
        

        

      
        query.getObjectInBackgroundWithId("w6P8mul99a")
            {
                (SchedObj: PFObject?, error: NSError?) -> Void in
                if error == nil && SchedObj != nil {
                    var Widget_Block = [Array<String>]()
                    var Time_Block = [Array<String>]()
                    Widget_Block.removeAll()
                    Time_Block.removeAll()
                    print("Retrived Information Successful")
                   
                   
                    
                    self.Schedule = SchedObj!
                    print(self.Schedule, terminator: "")
                    let Monday = Day(name:"Monday")
                    let Tuesday = Day(name:"Tuesday")
                    let Wednesday = Day(name:"Wednesday")
                    let Thursday = Day(name:"Thursday")
                    let Friday = Day(name:"Friday")
                    if(self.Schedule["MondayBlock"] != nil && self.Schedule["MondayTime"] != nil){
                        let bO: Array<String> = self.Schedule["MondayBlock"] as! Array<String>
                        let t: Array<String> = self.Schedule["MondayTime"] as! Array<String>
                        Widget_Block.append(bO)
                        Time_Block.append(t)
                        Monday.refreshDay(bO, times: t)
                    }
                    if(self.Schedule["TuesdayBlock"] != nil && self.Schedule["TuesdayTime"] != nil){
                        let bO: Array<String> = self.Schedule["TuesdayBlock"] as! Array<String>
                        let t: Array<String> = self.Schedule["TuesdayTime"] as! Array<String>
                        Widget_Block.append(bO)
                        Time_Block.append(t)
                        Tuesday.refreshDay(bO, times: t)
                    }
                    if(self.Schedule["WednesdayBlock"] != nil && self.Schedule["WednesdayTime"] != nil){
                        let bO: Array<String> = self.Schedule["WednesdayBlock"] as! Array<String>
                        let t: Array<String> = self.Schedule["WednesdayTime"] as! Array<String>
                        Widget_Block.append(bO)
                        Time_Block.append(t)
                        Wednesday.refreshDay(bO, times: t)
                    }
                    if(self.Schedule["ThursdayBlock"] != nil && self.Schedule["ThursdayTime"] != nil){
                        let bO: Array<String> = self.Schedule["ThursdayBlock"] as! Array<String>
                        let t: Array<String> = self.Schedule["ThursdayTime"] as! Array<String>
                        Widget_Block.append(bO)
                        Time_Block.append(t)
                        Thursday.refreshDay(bO, times: t)
                    }
                    if(self.Schedule["FridayBlock"] != nil && self.Schedule["FridayTime"] != nil){
                        let bO: Array<String> = self.Schedule["FridayBlock"] as! Array<String>
                        let t: Array<String> = self.Schedule["FridayTime"] as! Array<String>
                        Widget_Block.append(bO)
                        Time_Block.append(t)
                        Friday.refreshDay(bO, times: t)
                    }
                    Days.append(Monday)
                    Days.append(Tuesday)
                    Days.append(Wednesday)
                    Days.append(Thursday)
                    Days.append(Friday)
                    let currentDateTime = Monday.getDate_AsString()
                    let Day_Num = Monday.getDayOfWeek_fromString(currentDateTime)
                    var User_Info = [String]()
                    
                    
                    
                    
                    if(self.defaults!.objectForKey("ButtonTexts") != nil){
                        User_Info = self.defaults!.objectForKey("ButtonTexts") as! Array<String>
                    }
                    var Switch_Info = [Bool]()
                    if(self.defaults!.objectForKey("SwitchValues") != nil){
                        Switch_Info = self.defaults!.objectForKey("SwitchValues") as! Array<Bool>
                    }
                    print("")
                    print("Finding Widget Date ...")
                    var End_Times = [Int]()
                    if(self.Schedule["EndTimes"] != nil){
                        End_Times = self.Schedule["EndTimes"] as! Array<Int>
                    }
                    
                    
                    var minutes_until_nextblock = 0;
                    var blockName_Widget = " "
                    
                    if(Day_Num >= 0 && Day_Num <= 4){
                        
                        for i in Array((0...Widget_Block[Day_Num].count-1).reverse()){
                            
                          
                            
                            let dateAfter = Time_Block[Day_Num][i]
                            let CurrTime = Monday.NSDateToStringWidget(NSDate())

                        //      CurrTime = "-09-33";
                            
                            var End_Time_String = ""
                            if(i+1 <= Widget_Block[Day_Num].count-1){
                                End_Time_String = Time_Block[Day_Num][i+1]
                            }
                            
                            print("Date After : " + dateAfter)
                            print("Current Date : " + CurrTime)
                            
                            var hour4 = self.substring(dateAfter,StartIndex: 1,EndIndex: 3)
                            hour4 = hour4 + self.substring(dateAfter,StartIndex: 4,EndIndex: 6)
                            
                            var hour2 = self.substring(CurrTime,StartIndex: 1,EndIndex: 3)
                            hour2 = hour2 + self.substring(CurrTime,StartIndex: 4,EndIndex: 6)
                            
                            var end_time = self.substring(End_Time_String,StartIndex: 1,EndIndex: 3)
                            end_time = end_time + self.substring(End_Time_String,StartIndex: 4,EndIndex: 6)
                            
                            
                            let hour_one = Int(hour4)
                            let hour_two = Int(hour2)
                            let hour_after = Int(end_time)
                            
                            
                            print("Blcok  Date  hour : ")
                            print(hour_one, terminator: "")
                            print("Current Date hour: ")
                            print(hour_two, terminator: "")
                            print("After Date  hour : ")
                            print(hour_after)
                            
                            
                            
                            if(i == Widget_Block[Day_Num].count-1 && hour_two >= hour_one){
                                
                                let EndTime = End_Times[Day_Num]
                                if(hour_two! - EndTime < 0){
                                    
                                    
                                    minutes_until_nextblock = self.find_Minutes(hour_two!, hour_after: (EndTime))
                                    
                                    print("Miuntes until next blok " + String(minutes_until_nextblock))
                                    if(minutes_until_nextblock > 0){
                                        blockName_Widget = Widget_Block[Day_Num][i]
                                    }
                                    else{
                                        blockName_Widget = "GETTOCLASS"
                                    }
                                }
                                else{
                                    print("After School")
                                    blockName_Widget = "NOCLASSNOW"
                                }
                                
                                break;
                                
                            }
                            
                            
                            if(hour_two >= hour_one){
                                
                                
                                minutes_until_nextblock = self.find_Minutes(hour_two!, hour_after: (hour_after!))
                                
                                print("Miuntes unitl next block " + String(minutes_until_nextblock))
                                
                                if(minutes_until_nextblock > 0){
                                    
                                    blockName_Widget = Widget_Block[Day_Num][i]
                                }
                                else{
                                    blockName_Widget = "GETTOCLASS"
                                }
                                
                                break;
                            }
                            
                        }
                        
                    }

                   
                  

                    
                    
                    if(blockName_Widget == " "){
                        
                        blockName_Widget = "NOCLASSNOW"
                        
                    }
                    
                    
                    
                    print("Found the block name Widget " + blockName_Widget )
                    
                    if(blockName_Widget == "NOCLASSNOW"){
                        Block_Label.text = "No Class Now"

     
              
                        print("NO Class Now")
                        
                        
                    }
                    else if(blockName_Widget == "GETTOCLASS"){
                        Block_Label.text = "Passing Time"

                        print("Passing Time")
                        
                        let firstLunch = Switch_Info[Day_Num]
                        
                        let text = self.SetTextForOtherBlocks(Day_Num, Days: Days, firstLunch: firstLunch, User_Info: User_Info);
                        
                        
                        
                        
                        Order_label.text = "Schedule : " + text;

                        
                       
                    }
                    else{
                        
                        let firstLunch = Switch_Info[Day_Num]
                      
                        
                        let text = self.SetTextForOtherBlocks(Day_Num, Days: Days, firstLunch: firstLunch, User_Info: User_Info);
                        
                   //     println(text);
                        
                        
                        
                        for (date,block) in Days[Day_Num].time_to_block{
                            var message = block;
                            var block_copy = block;
                            
                            
                            
                            
                            
                            if(block_copy.characters.count == 2) {
                                
                                if(firstLunch && block_copy.hasSuffix("1")){
                                    
                                    
                                    message = "Lunch"
                                    
                                    
                                    
                                }
                                else if(!firstLunch && block_copy.hasSuffix("2")){
                                    
                                    message = "Lunch"
                                    
                                    
                                }
                                else{
                                    
                                    
                                 
                                    
                                    
                                    
                                    
                                    
                                    var counterDigit = 0;
                                    
                                    for i in block_copy.characters{
                                        
                                        if(counterDigit == 0){
                                            block_copy = String(i)
                                        }
                                        
                                        counterDigit++;
                                        
                                    }
                                    
                                    
                                    
                                }
                            }
                            
                            
                            
                            if(self.BlockOrder.indexOf(block_copy) != nil){
                                
                                let indexOfUserInfo = self.BlockOrder.indexOf(block_copy)!
                                
                                if(User_Info[indexOfUserInfo] != ""){
                                    message = User_Info[indexOfUserInfo]
                                    
                                }
                                
                                
                                
                                
                            }
                            
                            
                            if(block == blockName_Widget){
                                print("have found widget block " + block)
                                print("Message on Widget " + message)
                                print("In Extension")
                                Block_Label.text = "Current Block " + message
                              

                                Time_Label.text = "Minutes Left " + String(minutes_until_nextblock)
                                
                                
                                
                                Order_label.text = "Schedule : " + text;
                               
                                break;

                                
                            }
                            
                        }
                        
                    }
                    
                    
                    
                    
                    Success = true;
                    
                    
                    
                    
                    
                } else {
                    
                    
                    print("Information not received succesfully")
                }
        }
        
        
        
        return Success
    }
    
    
}
