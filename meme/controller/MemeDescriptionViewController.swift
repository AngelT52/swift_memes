import UIKit
import WebKit

class MemeDescriptionViewController: UIViewController {
    
    
    @IBOutlet weak var pictureImageView: UIImageView?
    
    var meme: Meme? = nil
    
    override func viewDidLoad() {


        super.viewDidLoad()
        
        title = meme?.name
        if let memeUrl = meme?.url {
            self.setImage(from: memeUrl)
        }
        
        //TODO: afficher toutes les infos d'un meme
        
    }
    
    @IBAction func modify(_ sender: Any){
        performSegue(withIdentifier: "memeModifyViewSegue", sender: self.meme)
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
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "memeModifyViewSegue" {
            
            if let vc = segue.destination as? MemeModifierViewController {
                vc.meme = sender as? Meme
                print("puedes")
            }
        }
    }
}

