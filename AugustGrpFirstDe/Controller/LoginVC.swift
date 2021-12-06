//
//  LoginVC.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 10/8/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        self.navigationItem.title = Titles.login
    }
    
    //MARK:- Private Methods
    private func isValidEmail(email: String) -> Bool {
        if !email.trimmed.isEmpty{
            if Validator.sharedInstance2.isValidEmail(email: email){
                return true
            }else {
                self.showAlert(title: AlertMessages.sorry, message: AlertMessages.invlidEmail,completion: nil)
                return false
            }
        }else {
            self.showAlert(title: AlertMessages.sorry, message: AlertMessages.enterEmail,completion: nil)
            return false
        }
    }
    private func isValidPassword(password: String) -> Bool {
        if !password.trimmed.isEmpty{
            if Validator.sharedInstance2.isValidPassword(password: password){
                return true
            }else {
                self.showAlert(title: AlertMessages.sorry, message: AlertMessages.invalidPass,completion: nil)
                return false
            }
        }else {
            self.showAlert(title: AlertMessages.sorry, message: AlertMessages.enterPass,completion: nil)
            return false
        }
    }
    private func check() -> Bool{
        if let email = emailTextFeild.text, isValidEmail(email: email),
           let password = passwordTextFeild.text, isValidPassword(password:password){
            if let user =  SqlManager.shared().getUser(email: email){
                if user.password == password{
                    UserDefaultManger.shared().setEmail(email: email)
                    return true
                }
                self.showAlert(title: AlertMessages.sorry, message: AlertMessages.enterPass,completion: nil)
                return false
            }
            self.showAlert(title: AlertMessages.sorry, message: AlertMessages.enterEmail,completion: nil)
            return false
        }
        self.showAlert(title: AlertMessages.sorry, message: AlertMessages.validData,completion: nil)
        return false
    }
    private func goToMovie (){
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil )
        let movieImageVc = sb.instantiateViewController(withIdentifier: ViewController.mediaVC) as! MediaVC
        self.navigationController?.pushViewController(movieImageVc, animated: true)
    }
    
    //MARK:- Actions
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if self.check() {
            self.goToMovie()
        }
    }
}
