    func update_widget() -> Bool{
        var Success = false;
        var Days = [Day]()
        var query = PFQuery(className:"Schedule")
        query.getObjectInBackgroundWithId("WUDNTSTACKOVERFLOWLIKETOSEETHIS")
            {
                (SchedObj: PFObject?, error: NSError?) -> Void in
                if error == nil && SchedObj != nil {
                    var Widget_Block = [Array<String>]()
                    var Time_Block = [Array<String>]()
                    Widget_Block.removeAll()
                    Time_Block.removeAll()
                    
                    self.Schedule = SchedObj!
                    print(self.Schedule)
                    var Monday = Day(name:"Monday")
                    var Tuesday = Day(name:"Tuesday")
                    var Wednesday = Day(name:"Wednesday")
                    var Thursday = Day(name:"Thursday")
                    var Friday = Day(name:"Friday")
                    if(self.Schedule["MondayBlock"] != nil && self.Schedule["MondayTime"] != nil){
                        var bO: Array<String> = self.Schedule["MondayBlock"] as! Array<String>
                        var t: Array<String> = self.Schedule["MondayTime"] as! Array<String>
                        Widget_Block.append(bO)
                        Time_Block.append(t)
                        Monday.refreshDay(bO, times: t)
                    }
                    if(self.Schedule["TuesdayBlock"] != nil && self.Schedule["TuesdayTime"] != nil){
                        var bO: Array<String> = self.Schedule["TuesdayBlock"] as! Array<String>
                        var t: Array<String> = self.Schedule["TuesdayTime"] as! Array<String>
                        Widget_Block.append(bO)
                        Time_Block.append(t)
                        Tuesday.refreshDay(bO, times: t)
                    }
                    if(self.Schedule["WednesdayBlock"] != nil && self.Schedule["WednesdayTime"] != nil){
                        var bO: Array<String> = self.Schedule["WednesdayBlock"] as! Array<String>
                        var t: Array<String> = self.Schedule["WednesdayTime"] as! Array<String>
                        Widget_Block.append(bO)
                        Time_Block.append(t)
                        Wednesday.refreshDay(bO, times: t)
                    }
                    if(self.Schedule["ThursdayBlock"] != nil && self.Schedule["ThursdayTime"] != nil){
                        var bO: Array<String> = self.Schedule["ThursdayBlock"] as! Array<String>
                        var t: Array<String> = self.Schedule["ThursdayTime"] as! Array<String>
                        Widget_Block.append(bO)
                        Time_Block.append(t)
                        Thursday.refreshDay(bO, times: t)
                    }
                    if(self.Schedule["FridayBlock"] != nil && self.Schedule["FridayTime"] != nil){
                        var bO: Array<String> = self.Schedule["FridayBlock"] as! Array<String>
                        var t: Array<String> = self.Schedule["FridayTime"] as! Array<String>
                        Widget_Block.append(bO)
                        Time_Block.append(t)
                        Friday.refreshDay(bO, times: t)
                    }
                    Days.append(Monday)
                    Days.append(Tuesday)
                    Days.append(Wednesday)
                    Days.append(Thursday)
                    Days.append(Friday)
                    var currentDateTime = Monday.getDate_AsString()
                    var Day_Num = Monday.getDayOfWeek_fromString(currentDateTime)
                    var User_Info = [String]()
                    let defaults = NSUserDefaults.standardUserDefaults()
                    if(defaults.objectForKey("ButtonTexts") != nil){
                        User_Info = defaults.objectForKey("ButtonTexts") as! Array<String>
                    }
                    var Switch_Info = [Bool]()
                    if(defaults.objectForKey("SwitchValues") != nil){
                        Switch_Info = defaults.objectForKey("SwitchValues") as! Array<Bool>
                    }

                    var End_Times = [Int]()
                    if(self.Schedule["EndTimes"] != nil){
                        End_Times = self.Schedule["EndTimes"] as! Array<Int>
                    }
                    
                    
                    var minutes_until_nextblock = 0;
                    var blockName_Widget = " "
                    
                    if(Day_Num >= 0 && Day_Num <= 4){
                        
                        for i in reverse(0...Widget_Block[Day_Num].count-1){
                            
                            
                            
                            var dateAfter = Time_Block[Day_Num][i]
                            var CurrTime = Monday.NSDateToStringWidget(NSDate())
                            var End_Time_String = ""
                            if(i+1 <= Widget_Block[Day_Num].count-1){
                                End_Time_String = Time_Block[Day_Num][i+1]
                            }
                            
                            println("Date After : " + dateAfter)
                            println("Current Date : " + CurrTime)
                            
                            var hour4 = self.substring(dateAfter,StartIndex: 1,EndIndex: 3)
                            hour4 = hour4 + self.substring(dateAfter,StartIndex: 4,EndIndex: 6)
                            
                            var hour2 = self.substring(CurrTime,StartIndex: 1,EndIndex: 3)
                            hour2 = hour2 + self.substring(CurrTime,StartIndex: 4,EndIndex: 6)
                            
                            var end_time = self.substring(End_Time_String,StartIndex: 1,EndIndex: 3)
                            end_time = end_time + self.substring(End_Time_String,StartIndex: 4,EndIndex: 6)
                            
                            
                            var hour_one = hour4.toInt()
                            var hour_two = hour2.toInt()
                            var hour_after = end_time.toInt()
                            
                            
                            println("Blcok  Date  hour : ")
                            print(hour_one)
                            println("Current Date hour: ")
                            print(hour_two)
                            println("After Date  hour : ")
                            println(hour_after)
                            
                            
                            
                            if(i == Widget_Block[Day_Num].count-1 && hour_two >= hour_one){
                                
                                var EndTime = End_Times[Day_Num]
                                if(hour_two! - EndTime < 0){
                                    
                                    
                                    minutes_until_nextblock = self.find_Minutes(hour_two!, hour_after: (EndTime-5))
                                    
                                    println("Miuntes until next blok " + String(minutes_until_nextblock))
                                    if(minutes_until_nextblock > 0){
                                        blockName_Widget = Widget_Block[Day_Num][i]
                                    }
                                    else{
                                        blockName_Widget = "GETTOCLASS"
                                    }
                                }
                                else{
                                    println("After School")
                                    blockName_Widget = "NOCLASSNOW"
                                }
                                
                                break;
                                
                            }
                            
                            
                            if(hour_two >= hour_one){
                                
                                
                                minutes_until_nextblock = self.find_Minutes(hour_two!, hour_after: (hour_after!-5))
                                
                                println("Miuntes unitl next block " + String(minutes_until_nextblock))
                                
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
                    
                    
                    
                    println("Found the block name Widget " + blockName_Widget )
                    
                    if(blockName_Widget == "NOCLASSNOW"){
       
                        
                        println("NO Class Now")
                        
                        
                    }
                    else if(blockName_Widget == "GETTOCLASS"){
              
                        println("Passing Time")
                        
                    }
                    else{
                        
                        var firstLunch = Switch_Info[Day_Num]
                        
                        for (date,block) in Days[Day_Num].time_to_block{
                            var message = block;
                            var block_copy = block;
                            
                            
                            
                            
                            
                            if(count(block_copy) == 2) {
                                
                                if(firstLunch && block_copy.hasSuffix("1")){
                                    
                                    
                                    message = "Lunch"
                                    
                                    
                                    
                                }
                                else if(!firstLunch && block_copy.hasSuffix("2")){
                                    
                                    message = "Lunch"
                                    
                                    
                                }
                                else{
                                    
                                    var counterDigit = 0;
                                    
                                    for i in block_copy{
                                        
                                        if(counterDigit == 0){
                                            block_copy = String(i)
                                        }
                                        
                                        counterDigit++;
                                        
                                    }
                                    
                                    
                                    
                                }
                            }
                            
                            
                            
                            if(find(self.BlockOrder,block_copy) != nil){
                                
                                var indexOfUserInfo = find(self.BlockOrder,block_copy)!
                                
                                if(User_Info[indexOfUserInfo] != ""){
                                    message = User_Info[indexOfUserInfo]
                                    
                                }
                            }
                            
                            
                            if(block == blockName_Widget){

                                self.WidgetText.text = message
                                break;
                       
                            }
                            
                        }
                        
                    }
                    
                    
                    
                    
                    Success = true;
                    
                    
                    
                    
                    
                } else {
                    
                    Success = false; 
                   
                }
        }
        return Success
    }