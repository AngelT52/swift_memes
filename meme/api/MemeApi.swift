import Alamofire
import SwiftyJSON
import PromiseKit

class MemeApi {
    
    //Fonction static pour ne pas a avoir a l'instancier a chaque fois qu'on veux la call
    static func getMemes() -> Promise<[Meme]> {
        var memes: [Meme] = []
        var data: Test
        
        // Gestion de l'asynchrone, on retourne une promesse
        return Promise { seal in
            
            // On fait l'appel dans la promesse
            AF.request("https://api.imgflip.com/get_memes").response { response in
                let json = JSON(response.data)
                
                
                let memesJSON = json["data"]["memes"].arrayValue
                print("api", memesJSON)
                for meme in memesJSON {
                    memes.append(Meme(name: meme["name"].stringValue,
                                      url: meme["url"].stringValue,
                                      id: meme["id"].stringValue,
                                      boxCount: meme["box_count"].stringValue
                                     )
                                )
                }
                print("memes")
                seal.fulfill(memes)
            }
        }
    }
    
    static func modifyMeme(id: String, textTop: String, textBot: String) -> Promise<String> {
        
        let parameters: [String: Any] = [
            "username" : "Ouais",
            "password" : "Ouais123456",
            "template_id" : id,
            "text0" : textTop,
            "text1" : textBot,
            ]
        // Gestion de l'asynchrone, on retourne une promesse
        return Promise { seal in
            
            // On fait l'appel dans la promesse
            AF.request("https://api.imgflip.com/caption_image",method: .post, parameters: parameters).response { response in
                let url = JSON(response.data)
                let dataJSON = url["data"]["url"].stringValue
                seal.fulfill(dataJSON)
            }
        }
    }
    
}

