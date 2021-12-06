//
//  UIViewController+AddGradinet.swift
//  AugustGrpFirstDe
//
//  Created by Mohamed Elshaer on 30/11/2021.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import UIKit

extension UIViewController {
    func addGradient() {
        self.view.layoutIfNeeded()
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        let gradientView = UIView()
        gradientView.layer.insertSublayer(gradient, at: 0)
        gradientView.alpha = 1
        gradientView.frame = self.view.bounds
        view.backgroundColor = .clear// el asasy clear
        view.addSubview(gradientView)//handif view gradient
        view.sendSubviewToBack(gradientView)//khalih hwa akher wahed wara
    }
}
