//
//  CoderManger.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 11/30/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import Foundation
class CoderManager {
    private static let sharedInstance = CoderManager()
    class func shared() -> CoderManager {
        return CoderManager.sharedInstance
    }
    // MARK:- properties
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK:- public Methods
    func encodUser(user: User) -> Data? {
        if let encoded = try? encoder.encode(user) {
            return encoded
        }
        return nil
    }
    func encodMedia(media: [Media]) -> Data? {
        if let encoded = try? encoder.encode(media) {
            return encoded
        }
        return nil
    }
    func decodedUser(userData: Data) -> User? {
        if let loadedUser = try? decoder.decode(User.self, from: userData){
            return loadedUser
        }
        return nil
    }
    func decodedMedia(mediaData: Data) -> [Media]? {
        if let loadedMedia = try? decoder.decode([Media].self, from: mediaData){
            return loadedMedia
        }
        return nil
    }
}
