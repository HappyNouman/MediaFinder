//
//  MediaResponse.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 11/25/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import Foundation

//MARK:- MediaType
enum MediaType: String {
    case movie = "movie"
    case tvShow = "tvShow"
    case all = "all"
    case music = "music"
}

//MARK:- MediaResponse
struct MediaResponse: Decodable {
    var resultCount: Int
    var results: [Media]
}
