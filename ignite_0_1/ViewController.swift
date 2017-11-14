//
//  ViewController.swift
//  ignite_0_1
//
//  Created by csimpson on 5/4/17.
//  Copyright © 2017 csimpson. All rights reserved.
//

import Cocoa

import SQLite

class ViewController: NSViewController {

    @IBOutlet weak var next_step: NSTextField!
    @IBOutlet weak var ns1: NSTextField!
    @IBOutlet weak var ns2: NSTextField!
    @IBOutlet weak var ns3: NSTextField!
    @IBOutlet weak var ns4: NSTextField!
    @IBOutlet weak var ns5: NSTextField!
    @IBOutlet weak var checkbox1: NSButton!
    @IBOutlet weak var error_label: NSTextField!
    
    @IBOutlet weak var test2: NSScrollView!
    @IBOutlet weak var bar_test1: NSTextField!

    //Setup for menu_task which is statusItem1 and menu_checkbox which is statusItem2
    let statusItem1 = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let statusItem2 = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let dataStore = SQLite_db.sharedInstance

        do {
            try dataStore.createTables()
//            setData()
        } catch _ {}
        
        print("Finish")
        

 }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

//Initialize arrays used to store next step list and next step completed list
    
    var ns_list = [String]()
    var ns_complete = [String?]()

    
//Record items into DB
    func ns_record(next_step: String) {

        do {
            let now = NSDate() //initialize time variable
            
            increment_rank() //+1 to all rank values in database, this should allow next insert to sit in #1 spot

            let data_row_id = try NextStepDataHelper.insert(some_data:
                    (
                    ns_id: nil,
                    dest_task: nil,
                    orig_task: nil,
                    next_step: next_step,
                    create_time: now.timeIntervalSinceReferenceDate,
                    start_time: now.timeIntervalSinceReferenceDate,
                    elapsed_time: nil,
                    rank: 1,
                    done: false
                    )
            )
            print (next_step, "inserted at row id = ", data_row_id)
        }
        catch _{
            print (next_step, " failed to insert into database")
        }

    }
    
//Increment rank function
    func increment_rank () {
        print ("increment rank function has been called")
        do {
            let records_updated = try NextStepDataHelper.increment()

/*
            let db = SQLite_db.sharedInstance.TTDB
            let rank = Expression<Int?>("rank")
            let TABLE_NAME = "ns_tbl"
            let table = Table(TABLE_NAME)
            
            let records_updated = try db!.run(table.update(rank <- rank + 1))
 
 */
        print ("Number of records updated = ", records_updated)
        } catch _ {
            print ("no records updated")
        }
        
    }
    
//Refresh Display of next steps
    func ns_refresh() {
        for index in 0...4{
            //Iterates until end of array is reached or reaches value of 4...whichever comes first
            if index < ns_list.count {
                
                //Puts checkbox for next step in the menu bar, if there is room
                if let menu_checkbox = statusItem2.button {
                    menu_checkbox.image = NSImage(named:NSImage.Name(rawValue: "checkbox"))
                    //    menu_checkbox.action = Selector(clear_ns(sender: as AnyObject))
                }
                
                //Puts current next step into menu bar, if there is room
                if let menu_task = statusItem1.button {
                    menu_task.title = ns_list[0]
                }
                
                //Put next step value into window and 5 slots available
                switch index {
                case 0:
                    ns1.stringValue = ns_list[0]
                case 1:
                    ns2.stringValue = ns_list[1]
                case 2:
                    ns3.stringValue = ns_list[2]
                case 3:
                    ns4.stringValue = ns_list[3]
                case 4:
                    ns5.stringValue = ns_list[4]
                default:
                    print ("triggered default case")
                }
            }
            else {
                    switch index {
                    case 0:
                        ns1.stringValue = ""
                    case 1:
                        ns2.stringValue = ""
                    case 2:
                        ns3.stringValue = ""
                    case 3:
                        ns4.stringValue = ""
                    case 4:
                        ns5.stringValue = ""
                    default:
                        print ("triggered default case for blank")
                    }
            }
        }
      
        return
    }
 
//clear top next step from list and save to completed next steps list
    func clear_ns() {
        //Stores checked off next step into completed_next_steps, and moves array sequence up...checks to see if there is a value in the array at slot 0
//        let now = NSDate()  //initialize time variable
        
        if ns_list.isEmpty {
        }
        else {
            ns_complete.insert(ns_list[0], at:0)
            ns_list.removeFirst()
            print (ns_list)
//            print (now2-read data from db for record at position 1)
        }
        return
    }


// Action on hitting enter key while in text entry field
    @IBAction func return_test(_ sender: Any) {
        let input_value = next_step.stringValue
        if input_value.isEmpty {
            error_label.stringValue = "Please enter your next step in the field below:"
        }
        else {
            ns_list.append(input_value)
            ns_record(next_step: input_value)
            next_step.stringValue = ""
        }
        
        ns_refresh()

//        bar_test1.textValue = item
    }
 
// Action on clicking "enter" button
    @IBAction func ns_button(_ sender: Any) {
        let input_value = next_step.stringValue
        if input_value.isEmpty {
            error_label.stringValue = "Please enter your next step in the field below."
        }
        else {
            ns_list.append(input_value)
            ns_record(next_step: input_value)
            next_step.stringValue = ""
        }
        
        ns_refresh()
    }

//Insert action to strikethrough task when checkbox is clicked on...also would like to do when task has focus and enter is hit.  Should also reverse when clicked a second time.  current issue is it just posts the text "strikethrough"
    
    @IBAction func Checkbox(_ sender: Any) {

/*
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString: @"Eezy Tutorials Website"];
        NSLog(@"%@",[attributedString mutableString]);
        
        let strikeThroughAttributes = [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        let labelString = NSAttributedString(string: "Hello, playground", attributes: strikeThroughAttributes)
        multline_test.stringValue = labelString
*/
        ns1.stringValue = "This is a cleared task...wish it had a strikethrough!"
       
        clear_ns()
        
        //Unchecks checkbox
        checkbox1.state = NSControl.StateValue(rawValue: 0)
        
        ns_refresh()
    }


}

