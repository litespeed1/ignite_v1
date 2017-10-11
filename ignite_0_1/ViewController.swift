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
    let statusItem1 = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let statusItem2 = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //identify path to users Application Support sub-directory: /Users/csimpson/Library/Application Support/examen-tech.ignite-0-1
        let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first! + "/" + Bundle.main.bundleIdentifier!
        
        // create directory if it doesn’t exist
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        
        
        let db: Connection
        
        do {
            db = try Connection("\(path)/db.sqlite3")
            print ("connected to ", path,"/db.sqlite3")
        } catch {
            //db = nil
            print ("Unable to open database")
        }

        // initialize variables
        let id = Expression<Int64>("id")
        let dest_task = Expression<String>("dest_task")
        let orig_task = Expression<String>("orig_task")
        let next_step = Expression<String>("next_step")
        let create_time = Expression<String>("create_time")
        let start_time = Expression<Double>("start_time")
        let stop_time = Expression<Double>("stop_time")
        let done = Expression<Bool>("done")
        let ns_list_tbl = Table("ns_list_tbl")
        

 }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

//Initialize arrays used to store next step list and next step completed list
    
    var ns_list = [String]()
    
    var ns_complete = [String?]()
    
    
//Refresh Display of next steps
    func ns_refresh() {
        for index in 0...4{
            //Iterates until end of array is reached or reaches value of 4...whichever comes first
            if index < ns_list.count {
                
                //Puts checkbox for next step in the menu bar, if there is room
                if let menu_checkbox = statusItem2.button {
                    menu_checkbox.image = NSImage(named:"checkbox")
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
        
        do {
            try db.run(ns_list_tbl.create { t in     // CREATE TABLE "users" (
                t.column(id, primaryKey: true)      //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(dest_task)
                t.column(orig_task)
                t.column(next_step)
                t.column(create_time)
                t.column(start_time)
                t.column(stop_time)
                t.column(done)
            })
        } catch {
            print ("problem setting up table")
        }
        
        //        let now = NSDate() //initialize time variable
        /*
         let insert = ns_list_tbl.insert(next_step <- "test of insert",create_time <- "11Jul2017")
         do {
         let rowid = try db.run(insert)
         }
         catch {
         print ("Unable to insert record")
         }
         */
        
        
        return
    }
 
//clear top next step from list and save to completed next steps list
    func clear_ns() {
        //Stores checked off next step into completed_next_steps, and moves array sequence up...checks to see if there is a value in the array at slot 0
        if ns_list.isEmpty {
        }
        else {
            ns_complete.insert(ns_list[0], at:0)
            ns_list.removeFirst()
            print (ns_list)
        }
        return
    }


// Action on hitting enter key while in text entry field
    @IBAction func return_test(_ sender: Any) {
        let item = next_step.stringValue
        if item.isEmpty {
            error_label.stringValue = "Please enter your next step in the field below:"
        }
        else {
            ns_list.append(item)
            

            next_step.stringValue = ""
        }
        
        ns_refresh()

//        bar_test1.textValue = item
    }
 
// Action on clicking "enter" button
    @IBAction func ns_button(_ sender: Any) {
        let item = next_step.stringValue
        if item.isEmpty {
            error_label.stringValue = "Please enter your next step in the field below."
        }
        ns_list.append(item)
        next_step.stringValue = ""
        
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
        checkbox1.state = 0
        
        ns_refresh()
    }


}

