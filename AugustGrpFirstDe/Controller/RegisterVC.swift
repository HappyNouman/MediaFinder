//
//  ViewController.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 10/6/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var nameTextLabel: UITextField!
    @IBOutlet weak var emailTextLabel: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        setUserImage()
        SqlManager.shared().createUserTable()
        self.navigationItem.title = Titles.register
    }
    
    //MARK:- Private Methods
    private func goToLogin(){
        let sb = UIStoryboard(name : StoryBoard.main, bundle: nil )
        let loginVC = sb.instantiateViewController(withIdentifier: ViewController.loginVC) as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    private func check() -> Bool{
        if let name = nameTextLabel.text, isValidName(name: name),
           let email = emailTextLabel.text, isValidEmail(email: email),
           let password = passwordTextFeild.text , isValidPassword(password:password),
           let address = addressTextField.text, isValidAddress(address: address),
           let image = userImageView.image, isEntredNewImage(image: image){
            let user = User(name: name, email: email, password: password, address: address, image: CodableImage(withImage: image))
            if let encodedUser = CoderManager.shared().encodUser(user: user){
                SqlManager.shared().insertUser(user: encodedUser)
            }
            return true
        }
        return false
    }
    private func isEntredNewImage(image: UIImage) -> Bool {
        if image == UIImage(named: "user") {
            self.showAlert(title:AlertMessages.sorry, message: AlertMessages.selectImage, completion: nil)
            return false
        }
        return true
    }
    private func setUserImage(){
        userImageView.image = UIImage(named: "user")
    }
    private func isValidEmail(email: String) -> Bool {
        if !email.trimmed.isEmpty{
            if Validator.sharedInstance2.isValidEmail(email: email){
                return true
            }else {
                self.showAlert(title: AlertMessages.sorry, message: AlertMessages.invlidEmail, completion: nil)
                return false
            }
        }else {
            self.showAlert(title: AlertMessages.sorry, message: AlertMessages.enterEmail, completion: nil)
            return false
        }
    }
    private func isValidPassword(password: String) -> Bool {
        if !password.trimmed.isEmpty{
            if Validator.sharedInstance2.isValidPassword(password: password){
                return true
            }else {  self.showAlert(title: AlertMessages.sorry, message: AlertMessages.invalidPass, completion: nil)
                return false
            }
        }else {
            self.showAlert(title: AlertMessages.sorry, message: AlertMessages.enterPass, completion: nil)
            return false
        }
    }
    private func isValidAddress(address: String) -> Bool {
        if !address.trimmed.isEmpty{
            return true
        }else {
            self.showAlert(title: AlertMessages.sorry, message: "empty address",completion: nil)
            return false
        }
    }
    private func isValidName(name: String) -> Bool {
        if !name.trimmed.isEmpty{
            return true
        }else {
            self.showAlert(title: "sorry", message: "empty name",completion: nil)
            return false
        }
    }
    @objc private func registerToLoginVC(){
        if check(){
            self.showAlert(title: "Success", message: "your account created successfully"){_ in
                self.goToLogin()
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func addressBtnTapped(_ sender: UIButton) {let sb = UIStoryboard(name : StoryBoard.main, bundle: nil )
        let mapVC = sb.instantiateViewController(withIdentifier: ViewController.mapVC) as! MapVC
        mapVC.delegate = self
        self.present(mapVC, animated: true, completion: nil )
    }
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        registerToLoginVC()
    }
    @IBAction func userImageBtnTapped(_ sender: UIButton) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        self.present(imagePickerVC, animated: true, completion: nil)
    }
    @IBAction func goToLoginBtnTapped(_ sender: Any) {
        self.goToLogin()
    }
}

//MARK:- UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ _picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[.originalImage] as? UIImage{
            self.userImageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- MessageSendingDelegate
extension RegisterVC: MessageSendingDelegate{
    func sendMessage(message: String){
        addressTextField.text = message
    }
}
