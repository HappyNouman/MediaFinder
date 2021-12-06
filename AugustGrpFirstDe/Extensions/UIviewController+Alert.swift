//
//  uiviewcontroller+aleart.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 10/30/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import UIKit

extension UIViewController{
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Titles.ok, style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
}
