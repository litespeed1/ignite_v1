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
    static func decrement() throws -> Int
    static func find(rank_in: Int) throws -> [String]
//    static func delete(item: T) throws -> Void
//    static func findAll() throws -> [T]?

}


class NextStepDataHelper: DataHelperProtocol {
    static let TABLE_NAME = "ns_tbl"
    static let table = Table(TABLE_NAME)
    static let ns_id = Expression<Int64>("ns_id")
    static let dest_task = Expression<String?>("dest_task")
    static let orig_task = Expression<String?>("orig_task")
    static let next_step = Expression<String>("next_step")
    static let create_time = Expression<Double?>("create_time")
    static let start_time = Expression<Double?>("start_time")
    static let elapsed_time = Expression<Double?>("elapsed_time")
    static let rank = Expression<Int?>("rank")
    static let done = Expression<Bool?>("done")
    
    typealias T = ns_array
    
    static func createTable() throws {
        guard let db = SQLite_db.sharedInstance.TTDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            let _ = try db.run( table.create(ifNotExists: true) {t in
                t.column(ns_id, primaryKey: true)
                t.column(dest_task, defaultValue: nil)
                t.column(orig_task, defaultValue: nil)
                t.column(next_step)
                t.column(create_time, defaultValue: nil)
                t.column(start_time, defaultValue: nil)
                t.column(elapsed_time, defaultValue: nil)
                t.column(rank, defaultValue: nil)
                t.column(done, defaultValue: nil)
            })
            
        } catch _ {
            // Error throw if table already exists
        }
        
}
    
//Create new task row in ns_table
    
    static func insert(some_data: T) throws -> Int64 {
        guard let db = SQLite_db.sharedInstance.TTDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if (some_data.next_step != nil) {
            let insert = table.insert(

                next_step <- some_data.next_step!,
                create_time <- some_data.create_time!,
                start_time <- some_data.start_time!,
                rank <- some_data.rank
             
            )
            do {
                let rowId = try db.run(insert)
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
    
//Increment rank value prior to new task creation

    static func decrement() throws -> Int {
        guard let db = SQLite_db.sharedInstance.TTDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            let non_zero_rank = table.filter(rank > 0)
            let update_rank = non_zero_rank.update(rank <- rank - 1)
            let rows_updated = try db.run(update_rank)
            guard rows_updated > 0 else {
                throw DataAccessError.update_error
            }
            print (rows_updated)
            return rows_updated
        } catch _ {
            throw DataAccessError.update_error
        }
    }
    
    


    static func find(rank_in: Int) throws -> [String] {
        guard let db = SQLite_db.sharedInstance.TTDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
//        let some_data: T
        var get_list = [String]()
        let rank_query = table.filter(rank <= rank_in && rank != 0)
        let items = try db.prepare(rank_query)
        for item in items {
            get_list += [try item.get(next_step)]
        }
        return get_list
    }
    
/*
     
     
     
    static func delete (item: T) throws -> Void {
        guard let db = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if let id = item.teamId {
            let query = table.filter(teamId == id)
            do {
                let tmp = try db.run(query.delete())
                guard tmp == 1 else {
                    throw DataAccessError.Delete_Error
                }
            } catch _ {
                throw DataAccessError.Delete_Error
            }
        }
}
    static func find(id: Int64) throws -> T? {
        guard let db = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(teamId == id)
        let items = try db.prepare(query)
        for item in  items {
            return Team(teamId: item[teamId] , city: item[city], nickName: item[nickName], abbreviation: item[abbreviation])
        }
        
        return nil
        
    }
    
    static func findAll() throws -> [T]? {
        guard let db = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        let items = try db.prepare(table)
        for item in items {
            retArray.append(Team(teamId: item[teamId], city: item[city], nickName: item[nickName], abbreviation: item[abbreviation]))
        }
        
        return retArray
        
    }
*/
    
}



