//
//  Media.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 11/25/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import Foundation

struct Media: Codable {
    
    var trailer: String?
    var artistName: String?
    var poster: String?
    var trackName: String?
    var longDescription: String?
    
    enum CodingKeys: String, CodingKey{
        case artistName, longDescription, trackName
        case trailer = "previewUrl"
        case poster = "artworkUrl100"
    }
}
