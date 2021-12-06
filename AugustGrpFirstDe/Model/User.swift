//
//  User.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 10/8/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import UIKit

//MARK:- User
struct User: Codable{
    var name: String!
    var email: String!
    var password: String!
    var address: String!
    var image: CodableImage!
}

//MARK:- CodableImage
struct CodableImage: Codable{
    let imageData: Data?
    func getImage() -> UIImage?{
        if let imageData = self.imageData{
            return UIImage(data: imageData)
        }
        return nil
    }
    init(withImage image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 1.0)
    }
}
