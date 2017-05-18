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
    @IBOutlet weak var task1: NSTextField!
    @IBOutlet weak var task2: NSTextField!
    @IBOutlet weak var task3: NSTextField!
    @IBOutlet weak var task4: NSTextField!
    @IBOutlet weak var task5: NSTextField!
    
    @IBOutlet weak var test2: NSScrollView!
    
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
    
    var focus_list = ["task1","task2","task3","task4","task5","task6"]
    
    @IBAction func return_test(_ sender: Any) {
        var name = next_step.stringValue
        if name.isEmpty {
            name = "Please enter your next step in the field below."
        }
        let item = name

        next_step.stringValue = ""
        task1.stringValue = item
        task2.stringValue = focus_list[1]
        task3.stringValue = focus_list[2]
        task4.stringValue = focus_list[3]
        task5.stringValue = focus_list[4]

//        bar_test1.textValue = item
    }
    
    @IBAction func ns_button(_ sender: Any) {
        var name = next_step.stringValue
        if name.isEmpty {
            name = "Please enter your next step in the field below."
        }
        let item = "Next Step: \(name)!"

        next_step.stringValue = ""
        task1.stringValue = focus_list [0]
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
       task1.stringValue = "This is a cleared task...wish it had a strikethrough!"
        
    }


}

