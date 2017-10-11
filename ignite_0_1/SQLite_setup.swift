//
//  SQLite_setup.swift
//  ignite_0_1
//
//  Created by csimpson on 7/1/17.
//  Copyright © 2017 csimpson. All rights reserved.
//

import Foundation
import SQLite

class SQLite_db {
    
}

let instance = SQLite_db()
private let db: Connection?


/*
import SQLite

class dbops {
    var path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first! + "/" + Bundle.main.bundleIdentifier!
    
    // create parent directory if it doesn’t exist
    do {
    try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    } catch let error as NSError {
        print (error.localizedDescription);
    }
    
 
}
*/
