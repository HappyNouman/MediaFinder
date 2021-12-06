//
//  sqlDataSave.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 11/17/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import Foundation
import SQLite

class SqlManager {
    static let sharedInstance2 = SqlManager()
    static func shared() -> SqlManager {
        
        return SqlManager.sharedInstance2
    }
    
    private var database: Connection!
    
    //MARK:- user Table columes
    private let userTable = Table("user")
    private let id = Expression<Int>("id")
    private let userData = Expression<Data>("userData")
    
    // MARK:- media table columes
    private let mediaTable = Table("mediaTable")
    private let emailData = Expression<String>("emailData")
    private let mediaHestoryData = Expression<Data>("mediaHestoryData")
    private let mediaTypeData = Expression<String>("mediaTypeData")
    
    
    func setupConnection(tableName: String){
        do{
            let doc = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = doc.appendingPathComponent(tableName).appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print (error)
        }
    }
    func createUserTable(){
        let creatTable = self.userTable.create{
            table in
            table.column(self.id, primaryKey: true)
            table.column(self.userData)
        }
        do{
            try self.database.run(creatTable)
            print ("the table is created")
        }catch {
            print(error)
        }
    }
    func createMediaTable(){
        let creatTable = self.mediaTable.create{
            table in
            table.column(self.mediaHestoryData)
            table.column(self.mediaTypeData)
            table.column(self.emailData)
        }
        do{
            try self.database.run(creatTable)
            print ("the table is created")
        }catch {
            print(error)
        }
    }
    func insertUser(user : Data){
        let insertUser = self.userTable.insert(self.userData <- user)
        do {
            try self.database.run(insertUser)
        } catch {
            print(error)
        }
    }
    func insertInMediaTable(email: String, mediaData: Data, type: String){
        deletMediaTable()
        let insertMedia = self.mediaTable.insert(self.emailData <- email, self.mediaHestoryData <- mediaData, self.mediaTypeData <- type)
        do {
            try self.database.run(insertMedia)
        }catch {
            print(error)
        }
    }
    func deletMediaTable(){
        do {
            if try database.run(mediaTable.delete()) > 0{
            } else {}
        }catch {
            print(error)
        }
    }
    func getMediaDataFromDB(email: String) -> (Data, String)? {
        do {
            let mediaData = try self.database.prepare(self.mediaTable)
            for media in mediaData {
                if email == media[self.emailData] {
                    let data = media[self.mediaHestoryData]
                    let type = media[self.mediaTypeData]
                    return (data, type)
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
    func getUser(email: String)->User?{
        do {
            let users = try self.database.prepare(self.userTable)
            for user in users{
                let data = user[self.userData]
                let decoder = JSONDecoder()
                if let loadUser = try? decoder.decode(User.self, from: data ){
                    if email == loadUser.email{
                        return loadUser
                    }
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
}
