//
//  APImanager.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 11/23/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import Alamofire

class APIManager{
    static func loadMediaArray(term: String, media: String, completion: @escaping (_ error: Error?, _ mediaarr: [Media]?) -> Void){
        let param = [ParameterKey.term: term, ParameterKey.media: media]
        AF.request(Url.base, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).response {
            response in
            if let error = response.error{
                completion(error,nil)
            }
            if let data = response.data {
                do{
                    let mediaArray = try JSONDecoder().decode(MediaResponse.self, from: data).results
                    completion (nil, mediaArray)
                }catch let error {
                    completion(error, nil)
                }
            }
        }
    }
}
