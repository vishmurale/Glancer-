//
//  ViewController.swift
//  Glancer
//
//  Created by Vishnu Murale on 5/13/15.
//  Copyright (c) 2015 Vishnu Murale. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var Blue: UIView!
    @IBOutlet weak var M: UISwitch!
    @IBOutlet weak var T: UISwitch!
    @IBOutlet weak var W: UISwitch!
    @IBOutlet weak var Th: UISwitch!
    @IBOutlet weak var F: UISwitch!
    
    
    
    @IBOutlet weak var Save: UIButton!
    var ArrayOfText = [String]()
    var ArrayOfField = [UITextField]()
    
    
    var ArrayOfBool = [Bool]()
    var ArrayOfSwitch = [UISwitch]()
    @IBOutlet var Gblock: UITextField!
    @IBOutlet var Fblock: UITextField!
    @IBOutlet var Eblock: UITextField!
    @IBOutlet var Dblock: UITextField!
    @IBOutlet var Ablock: UITextField!
    @IBOutlet var Bblock: UITextField!
    @IBOutlet var Cblock: UITextField!
    var timer = NSTimer();
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        

        
        super.viewDidLoad()
        let defaults = NSUserDefaults(suiteName:"group.vishnu.squad.widget")

        
        
        
        ArrayOfText.append(Ablock.text!)
        ArrayOfText.append(Bblock.text!)
        ArrayOfText.append(Cblock.text!)
        ArrayOfText.append(Dblock.text!)
        ArrayOfText.append(Eblock.text!)
        ArrayOfText.append(Fblock.text!)
        ArrayOfText.append(Gblock.text!)
        
        
        ArrayOfField.append(Ablock)
        ArrayOfField.append(Bblock)
        ArrayOfField.append(Cblock)
        ArrayOfField.append(Dblock)
        ArrayOfField.append(Eblock)
        ArrayOfField.append(Fblock)
        ArrayOfField.append(Gblock)
        
        
        ArrayOfBool.append(M.on)
        ArrayOfBool.append(T.on)
        ArrayOfBool.append(W.on)
        ArrayOfBool.append(Th.on)
        ArrayOfBool.append(F.on)
        
        ArrayOfSwitch.append(M)
        ArrayOfSwitch.append(T)
        ArrayOfSwitch.append(W)
        ArrayOfSwitch.append(Th)
        ArrayOfSwitch.append(F)
        
        
        self.Gblock.delegate = self;
        self.Fblock.delegate = self;
        self.Eblock.delegate = self;
        self.Dblock.delegate = self;
        self.Ablock.delegate = self;
        self.Bblock.delegate = self;
        self.Cblock.delegate = self;
        

        if(defaults!.objectForKey("ButtonTexts") == nil){
            defaults!.setObject(ArrayOfText, forKey: "ButtonTexts")
        }
        else {
            let UserArray: [String] = defaults!.objectForKey("ButtonTexts") as! Array<String>
            
            for index in 0...UserArray.count-1{
                ArrayOfField[index].text = UserArray[index]
            }
        }
        
        if(defaults!.objectForKey("SwitchValues") == nil){
            defaults!.setObject(ArrayOfBool, forKey: "SwitchValues")
        }
        else {
            let UserSwitch: [Bool] = defaults!.objectForKey("SwitchValues") as! Array<Bool>
            
            for index in 0...UserSwitch.count-1{
                ArrayOfSwitch[index].on = UserSwitch[index]
            }
        }
        
        
        Save.addTarget(self, action: "buttonTapped", forControlEvents: .TouchUpInside)
        
      
        appDelegate.update()
        
            
//        
        for day in appDelegate.Days{
            
            print(day.name);
            
            
            
       
            
            var length = day.ordered_times.count;
            
            for (index,time) in day.ordered_times.enumerate(){
    
                
                let block_name = day.ordered_blocks[index];
                let user_data_for_block = day.messages_forBlock[block_name];
                
                print(time + " : " + block_name + " => " + user_data_for_block!);
                
                
                
                
                
            }
            
            
            
            
        }
        
        
        
        }
        
     
        
        
        
    
    
    func buttonTapped(){

        let defaults = NSUserDefaults(suiteName:"group.vishnu.squad.widget")

        
        ArrayOfText.removeAll()
        ArrayOfBool.removeAll()
        
        ArrayOfText.append(Ablock.text!)
        ArrayOfText.append(Bblock.text!)
        ArrayOfText.append(Cblock.text!)
        ArrayOfText.append(Dblock.text!)
        ArrayOfText.append(Eblock.text!)
        ArrayOfText.append(Fblock.text!)
        ArrayOfText.append(Gblock.text!)
        
        
        ArrayOfBool.append(M.on)
        ArrayOfBool.append(T.on)
        ArrayOfBool.append(W.on)
        ArrayOfBool.append(Th.on)
        ArrayOfBool.append(F.on)
        
        defaults!.setObject(ArrayOfText, forKey: "ButtonTexts")
        defaults!.setObject(ArrayOfBool, forKey: "SwitchValues")
        
        
        appDelegate.update()
        
        print("_____________________________________________________________________")
        print("Scheduled Notifications")

        
        let alert = UIAlertController(title: "Save", message: "Congrats your data has been Saved!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    
    
}

