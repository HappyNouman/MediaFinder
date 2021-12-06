//
//  UserDefaultManger.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 10/31/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import Foundation

class UserDefaultManger{
    private static let sharedInstance = UserDefaultManger()
    static func shared() -> UserDefaultManger {
        return UserDefaultManger.sharedInstance
    }
    private let def = UserDefaults.standard
    func setEmail(email: String){
        def.set(email, forKey: "userEmail")
    }
    func getUserEmail() -> String? {
        if let email = def.string(forKey: "userEmail"){
            return email
        }
        return nil
    }
    func setIsLoggedIn(Key: Bool){
        def.set(Key, forKey: "isLogedIn")
    }
}
