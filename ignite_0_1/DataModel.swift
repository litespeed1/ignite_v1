//
//  DataModel.swift
//  ignite_0_1
//
//  Created by csimpson on 10/21/17.
//  Copyright © 2017 csimpson. All rights reserved.
//

import Foundation

/*
//Use this if I need to restrict the data stored to a specific set of values (e.g. drop down kind of list)
 
 enum Positions: String {
    case Pitcher = "Pitcher"
    case Catcher = "Catcher"
    case FirstBase = "First Base"
    case SecondBase = "Second Base"
    case ThirdBase = "Third Base"
    case Shortstop = "Shortstop"
    case LeftField = "Left Field"
    case CenterField = "Center Field"
    case RightField = "Right field"
    case DesignatedHitter = "Designated Hitter"
}
*/

//These are the table data structures/values

// initialize data structures to pass from ViewController to DataHelper

typealias ns_array = (
    ns_id: Int64?,
    dest_task: String?,
    orig_task: String?,
    next_step: String?,
    create_time: Double?,   //stored as numberic from swift time reference
    start_time: Double?,    //stored as numberic from swift time reference
    elapsed_time: Double?,  //difference in seconds that task was actual the focus and active before completing
    rank: Int,              //top 5 values appear in interface...full list in a separate "sorting" screen
    done: Bool?
)


