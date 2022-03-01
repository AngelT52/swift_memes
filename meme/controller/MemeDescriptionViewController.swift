//
//  BeerDescriptionViewController.swift
//  ApiPractice
//
//  Created by jficerai on 25/02/2021.
//

import UIKit
import WebKit

class MemeDescriptionViewController: UIViewController {
    
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    var meme: Meme? = nil
    
    override func viewDidLoad() {


        super.viewDidLoad()
        
        print(meme)
        if let memeUrl = meme?.url {
            self.setImage(from: memeUrl)
        }
        
        //TODO: afficher toutes les infos d'une biere
        
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.pictureImageView.image = image
            }
        }
    }
}

