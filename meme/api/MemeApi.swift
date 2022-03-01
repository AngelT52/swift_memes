//
//  BeerApi.swift
//  ApiPractice

import Alamofire
import SwiftyJSON
import PromiseKit

class MemeApi {
    
    //Fonction static pour ne pas a avoir a l'instancier a chaque fois qu'on veux la call
    static func getMemes() -> Promise<[Meme]> {
        var memes: [Meme] = []
        
        // Gestion de l'asynchrone, on retourne une promesse
        return Promise { seal in
            
            // On fait l'appel dans la promesse
            AF.request("https://api.imgflip.com/get_memes").response { response in
                let json = JSON(response.data)
                
                
                let memesJSON = json["data"]["memes"].arrayValue
                print("api", memesJSON)
                for meme in memesJSON {
                    memes.append(Meme(name: meme["name"].stringValue,
                                           url: meme["url"].stringValue
                    ))
                }
                print(memes)
                seal.fulfill(memes)
            }
        }
    }
}

