//
//  Constraints.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 11/28/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import Foundation

//MARK:- StoryBoard
struct StoryBoard {
    static let main = "Main"
}

//MARK:- ViewController
struct ViewController {
    static let registerVC = "RegesterVC"
    static let loginVC = "LoginVC"
    static let profileVC = "ProfileVC"
    static let mapVC = "MapVC"
    static let mediaVC = "MediaVC"
    
}

//MARK:- Url
struct Url {
    static let base = "https://itunes.apple.com/search"
}

//MARK:- ParameterKey
struct ParameterKey {
    static let term = "term"
    static let media = "media"
}

//MARK:- SQLTablesKeys
struct SQLTablesKeys {
    static let idData = "id"
    static let email = "email"
}

//MARK:- MediaKeys
struct MediaKeys {
    static let media = "Media"
    static let moviesCell = "MoviesCell"
    static let movie = "Movie"
}

//MARK:- Titles
struct Titles {
    static let profile = "Profile"
    static let register = "Register"
    static let login = "Login"
    static let logout = "Logout"
    static let ok = "OK"
}

//MARK:- AlertMessages
struct AlertMessages {
    static let success = "Success"
    static let sorry = "Sorry"
    static let enterEmail="Please enter email"
    static let invlidEmail="invalid email"
    static let invalidPass = "Please Enter Valid Password \n it need to be \n at least 1 uppercase \n one lowercase \n 8 characters total"
    static let enterPass = "Please enter password"
    static let validData = "please enter valid data"
    static let selectImage = "please select profile image"
}
