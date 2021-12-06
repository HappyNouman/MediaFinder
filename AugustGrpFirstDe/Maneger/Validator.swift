//
//  Validators.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 10/30/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import Foundation

class Validator {
    
    //MARK:- Singelton
    static let sharedInstance2 = Validator()
    static func shared()-> Validator{
        return Validator.sharedInstance2
    }
    
    //MARK:- Public Methods
    func isValidEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: email)
    }
    func isValidPassword(password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: password)
    }
}
