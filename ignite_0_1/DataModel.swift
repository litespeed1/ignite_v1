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

// initialize variables

typealias ns_array = (
    ns_id: Int64?,
    dest_task: String?,
    orig_task: String?,
    next_step: String?,
    create_time: Double?,
    start_time: Double?,
    stop_time: Double?,
    done: Bool?
)


