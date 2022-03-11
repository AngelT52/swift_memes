import UIKit
import WebKit

class MemeModifierViewController: UIViewController {
    
    
    @IBOutlet weak var pictureImageView: UIImageView?
    @IBOutlet weak var topTextInput: UITextField?
    @IBOutlet weak var bottomTextInput: UITextField?
    
    var meme: Meme? = nil
    var link: String?
    
    override func viewDidLoad() {


        super.viewDidLoad()
        
        title = meme?.name
        if let memeUrl = meme?.url {
            self.setImage(from: memeUrl)
        }
        
        //TODO: afficher toutes les infos d'un meme
        
    }
    
    @IBAction func modify(_ sender: Any){
        if let memeId = meme?.id{
            MemeApi.modifyMeme(id: memeId+"", textTop: "pouler", textBot: "poulet").done { res in
                
            }
        } else {
            MemeApi.modifyMeme(id: "181913649", textTop: "pouler", textBot: "poulet").done { res in
                
            }
        }
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.main.async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            print("tocar", imageData)
            DispatchQueue.main.async {
                self.pictureImageView?.image = image
                print("tocar", image)
            }
        }
    }
}

