//
//  ViewController.swift
//  ignite_0_1
//
//  Created by csimpson on 5/4/17.
//  Copyright © 2017 csimpson. All rights reserved.
//

import Cocoa

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
    let statusItem1 = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let statusItem2 = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    @IBOutlet weak var bar_test1: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

//Set dummy values for tasks to help with display test
    
    var ns_list = [String]()
    
    var ns_complete = [String?]()
    
//Refresh Display of next steps
    func ns_refresh() {
        for index in 0...4{
            //Iterates until end of array is reached and sets missing arrays to ""
            if index < ns_list.count {
                print (ns_list[index])
            }else {
                ns_list += [""]
            }
        }

        ns1.stringValue = ns_list[0]
        ns2.stringValue = ns_list[1]
        ns3.stringValue = ns_list[2]
        ns4.stringValue = ns_list[3]
        ns5.stringValue = ns_list[4]

        if let menu_task = statusItem1.button {
            menu_task.title = ns_list[0]
        }
        if let menu_checkbox = statusItem2.button {
            menu_checkbox.image = NSImage(named:"checkbox")
        }

        // Eventually might add this back in if there is a sub-nav to the task...
        //            button.action = Selector("printQuote:")
        return
    }

// Action on hitting enter key while in text entry field
    @IBAction func return_test(_ sender: Any) {
        let item = next_step.stringValue
        if item.isEmpty {
            error_label.stringValue = "Please enter your next step in the field below:"
        }
        else {
            ns_list.insert(item, at:0)
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
        ns_list.insert(item, at:0)
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
       
        //Stores checked off next step into completed_next_steps, and moves array sequence up
        ns_complete.insert(ns_list[0], at:0)
        ns_list.removeFirst()
        print (ns_list)
        
        //Unchecks checkbox
        checkbox1.state = 0
        
        ns_refresh()
    }


}

