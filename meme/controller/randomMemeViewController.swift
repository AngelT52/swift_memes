import Foundation
import UIKit
import AVFoundation

class randomMemeViewController: UIViewController {
    
    //MARK: Variables
    var memes: [Meme] = []
    var secondsRemaining = 2.0
    var meme: Meme? = nil
    
    //MARK: Outlets
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: ApiCall pour recevoir le tableau de meme
        MemeApi.getMemes().done { memes in
            self.memes = memes
            print("nm1", memes)
            self.getRandomMeme()
            self.randomize()
        }
        
        // ---- BLOC A SUPPRIMER ----
        /*let beer = getRandomMeme()
        if let url = URL(string: beer.pictureUrl), let imgData = try? Data(contentsOf: url) {
            let image = UIImage(data: imgData)
            self.pictureImageView.image = image
        }
        self.titleLabel.text = beer.name*/
        // ---------------------------
    }
    
    let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "another-one-meme", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()

       
    
    //MARK: IBActions
    @IBAction func randomize(_ sender: Any) {
        do {
        audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
        audioPlayer.play()
        self.randomize()
        } catch {
            
        }
    }
    
    @IBAction func back(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func modify(_ sender: Any){
        performSegue(withIdentifier: "memeModifyViewSegue", sender: self.meme)
    }
    
    //MARK: Functions
    
    func randomize() {
        //TODO: display beer
         self.meme = self.getRandomMeme()
         if let memeUrl =  self.meme?.url{
             self.setImage(from: memeUrl)
             self.titleLabel.text = self.meme?.name
             
         } else {
             print("tocar")
         }
                
            
    }
    
    func getRandomMeme() -> Meme {
        let m = memes.randomElement()
        if let u = m?.url {
            if let o = m?.name {
                if let t = m?.id{
                    if let n = m?.boxCount{
                        return Meme(name: o, url: u, id: t, boxCount: n)
                    }
                    
                }
            }
        }
        return Meme(name: "non", url: "https://cdn.radiofrance.fr/s3/cruiser-production/2019/10/22f8d83b-2dbb-4156-8f6d-9cc13b94e16f/838_rickmorty.webp", id: "181913649", boxCount: "2")
        
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
            }
        }
    }
}
