//
//  AppDelegate.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 10/6/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK:- Propreties
    var window: UIWindow?
    
    //MARK:- AppDelegate Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.handlRoot()
        IQKeyboardManager.shared().isEnabled = true
        SqlManager.shared().setupConnection(tableName: "mediaTable")
        SqlManager.shared().setupConnection(tableName: "userTable")
        return true
    }
    
    //MARK:- Public Methods
    func openOnLoginScreen() {
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil )
        let loginVC = sb.instantiateViewController(withIdentifier: ViewController.loginVC) as! LoginVC
        let navController = UINavigationController(rootViewController: loginVC)
        self.window?.rootViewController = navController
    }
}

//MARK:- Private Methods
extension AppDelegate {
    private func handlRoot(){
        let dev = UserDefaults.standard
        if let isloggedIn = dev.object(forKey: "isLogedIn") as? Bool {
            if isloggedIn{
                self.openOnMediaScreen()
            }else{
                self.openOnLoginScreen()
            }
        }
    }
    private func openOnProfileScreen() {
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let profilVc = sb.instantiateViewController(withIdentifier: ViewController.profileVC) as! ProfileVC
        self.window?.rootViewController = profilVc
    }
    private func openOnMediaScreen() {
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let movieVC = sb.instantiateViewController(withIdentifier: ViewController.mediaVC) as! MediaVC
        let navController = UINavigationController(rootViewController: movieVC)
        self.window?.rootViewController = navController
    }
}
