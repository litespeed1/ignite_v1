//
//  SQLite_setup.swift
//  ignite_0_1
//
//  Created by csimpson on 7/1/17.
//  Copyright © 2017 csimpson. All rights reserved.
//

import Foundation
import SQLite

enum DataAccessError: Error {
    case Datastore_Connection_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
}

class SQLite_db {
    static let sharedInstance = SQLite_db()
    let TTDB: Connection?
    private init() {
        
        var path = "timetrackerDB.sqlite"
        
        //identify path to users Application Support sub-directory: /Users/csimpson/Documents/timetrackerDB.sqlite
        if let dirs: [NSString] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as [NSString] {
            let dir = dirs[0]
            path = dir.appendingPathComponent("timetrackerDB.sqlite");
        }
        print (path)
        do {
            TTDB = try Connection(path)
        } catch _ {
            TTDB = nil
        }
    }
    func createTables() throws{
        do {
            try NextStepDataHelper.createTable()
        } catch {
            throw DataAccessError.Datastore_Connection_Error
        }
        
    }
}




/*
 Alternate Directory Creation code...revisit later
 
 //identify path to users Application Support sub-directory: /Users/csimpson/Library/Application Support/examen-tech.ignite-0-1
 let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first! + "/" + Bundle.main.bundleIdentifier!
 
 // create directory if it doesn’t exist
 do {
 try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
 } catch let error as NSError {
 print(error.localizedDescription);
 }
*/
