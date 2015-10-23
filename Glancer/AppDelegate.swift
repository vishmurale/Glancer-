//
//  AppDelegate.swift
//  Glancer
//
//  Created by Vishnu Murale on 5/13/15.
//  Copyright (c) 2015 Vishnu Murale. All rights reserved.
//

import UIKit
import Parse



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let BlockOrder = ["A","B","C","D","E","F","G"]
    
    var Days = [Day]()
    var Id : String = ""
    var MondayExists = false
    var Timer = NSTimer();
    var pushNotificationController:PushNotificationController?
    var Schedule = PFObject(className:"Schedule")
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(
            UIApplicationBackgroundFetchIntervalMinimum)
        
        
        self.pushNotificationController = PushNotificationController()
        
        // Register for Push Notitications, if running iOS 8
        if application.respondsToSelector("registerUserNotificationSettings:") {
            
            let types:UIUserNotificationType = ([.Alert, .Badge, .Sound])
            let settings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
            
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        
        
        //Query Parse For Monday-Friday Schedules
        
        
        // Override point for customization after application launch.
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("didRegisterForRemoteNotificationsWithDeviceToken")
        
        let currentInstallation = PFInstallation.currentInstallation()
        
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackgroundWithBlock { (succeeded, e) -> Void in
            //code
        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("failed to register for remote notifications:  (error)")
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("didReceiveRemoteNotification")
        PFPush.handlePush(userInfo)
    }
    
    
    
    func update() -> Bool{
        
        var Success = false;
        
        Days.removeAll()
        
        
        
        
        
        let query = PFQuery(className:"Schedule")
        
        
        query.getObjectInBackgroundWithId("w6P8mul99a")
            {
                (SchedObj: PFObject?, error: NSError?) -> Void in
                if error == nil && SchedObj != nil {
                    
                    
                    
                    let app:UIApplication = UIApplication.sharedApplication()
                    for Event in app.scheduledLocalNotifications! {
                        var notification = Event as! UILocalNotification
                        app.cancelLocalNotification(notification)
                    }
                    
                   
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
                    
                    self.Days.append(Monday)
                    self.Days.append(Tuesday)
                    self.Days.append(Wednesday)
                    self.Days.append(Thursday)
                    self.Days.append(Friday)
                 
                 
                    
                    
                    
                    
                    let currentDateTime = Monday.getDate_AsString()
                    let Day_Num = Monday.getDayOfWeek_fromString(currentDateTime)
                    
                    var index : Double = 0;
                    index = -Double(Day_Num);
                    
                    
                    /*
                    M T W TH F SAT SUN
                    0 1 2 3  4 5   6
                    
                    */
                    
                    var User_Info = [String]()
                    let defaults = NSUserDefaults(suiteName:"group.vishnu.squad.widget")

                    if(defaults!.objectForKey("ButtonTexts") != nil){
                        User_Info = defaults!.objectForKey("ButtonTexts") as! Array<String>
                    }
                    
                    var Switch_Info = [Bool]()
        
                    
                    if(defaults!.objectForKey("SwitchValues") != nil){
                        Switch_Info = defaults!.objectForKey("SwitchValues") as! Array<Bool>
                    }

                    
                    var dayCounter = 0;
                    
                    
                    for day in self.Days{
                        
                        
                        
                        print(self.Days.count)
                        print("")
                        print("")
                        print("")
                        
                        print("before crash" )
                        print(Switch_Info);
                        print(dayCounter);
                        
                        var firstLunch = Switch_Info[dayCounter]
                        
                        for (date,block) in day.time_to_block{
                            
                            
                            

                            
                            
                            
                            
                            
                            var message = block;
                            var block_copy = block;
                            
                            
                            print("Block " + block + " ", terminator: "")
                            
                            
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
                            
                            
                            var Earlydate = date.dateByAddingTimeInterval(-60*5)
                            let localNotification:UILocalNotification = UILocalNotification()
                            localNotification.alertAction = "Glancer"
                            localNotification.alertBody = "5 minutes to get to " + message;
                            
                            
                            
                            day.messages_forBlock[block] = message;
                            
                            
                            Earlydate = Earlydate.dateByAddingTimeInterval(60 * 60 * 24 * index)
                            
                            
                            let DateScheduled = day.NSDateToString(Earlydate)
                            print(day.name + " Date Scheduled : " + DateScheduled + " " + message)
                            localNotification.fireDate = Earlydate
                            localNotification.repeatInterval = NSCalendarUnit.WeekOfYear
                            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                            
                            
                            


                        }
                        dayCounter++;
                        index++;
                    }

                    Success = true;

                    
                    
                    
              
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                } else {
                    print("Error - Failed!")
                }
        }
        return Success
    }
    
    ///delete this function after
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
    
    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        Timer.invalidate()
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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

    

    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        let x = update();
        
        
        print("Fetching")
        
        
        if(x){
            
            completionHandler(.NewData)
        }
        else{
            completionHandler(.Failed)
        }
        
        
        print("Fetching Done")
        
        
    }
    
    
       
    
    
    
    
    
}

