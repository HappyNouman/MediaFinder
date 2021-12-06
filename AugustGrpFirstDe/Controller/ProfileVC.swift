//
//  ProfileVC.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 10/9/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    //MARK:- Propreties
    var user: User?
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        setData()
        addlogoutButton()
        addGradient()
        self.navigationItem.title = Titles.profile
    }
}

//MARK:- Private Methods
extension ProfileVC {
    private func setData(){
        self.emailLabel.text = user?.email
        self.nameLabel.text = user?.name
        self.addressLabel.text = user?.address
        self.userImageView.image = user?.image.getImage()
    }
    private func getUserData(){
        if let email = UserDefaultManger.shared().getUserEmail(){
            if let user = SqlManager.shared().getUser(email: email){
                self.user = user
            }
        }
    }
    private func addlogoutButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Titles.logout, style: .plain, target: self, action: #selector(goTologin))
    }
    @objc private func goTologin(){
        if let appDelagate = UIApplication.shared.delegate as? AppDelegate {
            appDelagate.openOnLoginScreen()
        }
    }
}
