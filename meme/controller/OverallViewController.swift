import UIKit
import Alamofire
import SwiftyJSON

class OverallViewController: UICollectionViewController {
    var memes: [Meme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshCardsList()
        
    }
    
    func refreshCardsList() {
        MemeApi.getMemes().done { memes in
            self.memes = memes
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Datasource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellView =  self.collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! MemeViewCell
        
        loadImage(url: memes[indexPath.row].url, image: cellView.cellImage, loader: cellView.loaderSpin)
        
        return cellView
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "overallSegue", sender: memes[indexPath.row])
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "overallSegue" {
            
            if let vc = segue.destination as? MemeDescriptionViewController {
                vc.meme = sender as? Meme
            }
        }
    }
    
    func loadImage(url: String, image: UIImageView, loader: UIActivityIndicatorView){
            loader.isHidden = false
            image.isHidden = true
            
            DispatchQueue.global().async {
                let tmpUrl = URL(string: url)
                    
                let data = try? Data(contentsOf: tmpUrl!)
                    
                DispatchQueue.main.async {
                    image.image = UIImage(data: data!)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        loader.isHidden = true
                        image.isHidden = false
                    }
                }
            }
        }
    
    /*
    //MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // When user selects the cell
    }

    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        // When user deselects the cell
    }*/
}

extension OverallViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
}

class MemeViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var loaderSpin: UIActivityIndicatorView!
}
