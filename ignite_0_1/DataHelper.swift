//
//  DataHelper.swift
//  ignite_0_1
//
//  Created by csimpson on 10/21/17.
//  Copyright © 2017 csimpson. All rights reserved.
//

import Foundation
import SQLite

protocol DataHelperProtocol {
    associatedtype T
    static func createTable() throws -> Void
    static func insert(some_data: T) throws -> Int64
/*    static func delete(item: T) throws -> Void
    static func findAll() throws -> [T]?
*/
}


class NextStepDataHelper: DataHelperProtocol {
    static let TABLE_NAME = "ns_tbl"
    static let table = Table(TABLE_NAME)
    static let ns_id = Expression<Int64>("ns_id")
    static let dest_task = Expression<String?>("dest_task")
    static let orig_task = Expression<String?>("orig_task")
    static let next_step = Expression<String>("next_step")
    static let create_time = Expression<Double>("create_time")
    static let start_time = Expression<Double>("start_time")
    static let stop_time = Expression<Double>("stop_time")
    static let done = Expression<Bool>("done")
    
    typealias T = ns_array
    
    static func createTable() throws {
        guard let DB = SQLite_db.sharedInstance.TTDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            let _ = try DB.run( table.create(ifNotExists: true) {t in
                t.column(ns_id, primaryKey: true)
                t.column(dest_task)
                t.column(orig_task)
                t.column(next_step)
                t.column(create_time)
                t.column(start_time)
                t.column(stop_time)
                t.column(done)
            })
            
        } catch _ {
            // Error throw if table already exists
        }
        
}

    static func insert(some_data: T) throws -> Int64 {
        guard let DB = SQLite_db.sharedInstance.TTDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if (some_data.next_step != nil) {
            let insert = table.insert(
                dest_task <- some_data.dest_task!,
                orig_task <- some_data.orig_task!,
                next_step <- some_data.next_step!,
                create_time <- some_data.create_time!,
                start_time <- some_data.start_time!,
                stop_time <- some_data.stop_time!,
                done <- some_data.done!                
            )
            do {
                let rowId = try DB.run(insert)
                guard rowId > 0 else {
                    throw DataAccessError.Insert_Error
                }
                return rowId
            } catch _ {
                throw DataAccessError.Insert_Error
            }
        }
        throw DataAccessError.Nil_In_Data
        
    }
/*
    static func delete (item: T) throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if let id = item.teamId {
            let query = table.filter(teamId == id)
            do {
                let tmp = try DB.run(query.delete())
                guard tmp == 1 else {
                    throw DataAccessError.Delete_Error
                }
            } catch _ {
                throw DataAccessError.Delete_Error
            }
        }
}
    static func find(id: Int64) throws -> T? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(teamId == id)
        let items = try DB.prepare(query)
        for item in  items {
            return Team(teamId: item[teamId] , city: item[city], nickName: item[nickName], abbreviation: item[abbreviation])
        }
        
        return nil
        
    }
    
    static func findAll() throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        let items = try DB.prepare(table)
        for item in items {
            retArray.append(Team(teamId: item[teamId], city: item[city], nickName: item[nickName], abbreviation: item[abbreviation]))
        }
        
        return retArray
        
    }
*/
    
}



