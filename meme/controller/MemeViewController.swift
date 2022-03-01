import UIKit
import Alamofire
import SwiftyJSON

class MemeViewController: UITableViewController {
    
    //MARK: - Variables
    var memes: [Meme] = []
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Memes List"
        refreshMemeList()
    }
    
    //MARK: - Custom Functions
    func refreshMemeList() {
        MemeApi.getMemes().done { memes in
            self.memes = memes
            self.tableView.reloadData()
        }
        
        
    }
    
    
    //MARK: - Datasource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "beerCell")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        //cell.textLabel?.text = self.beers[indexPath.row].name
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath)
             
        // Configure the cell’s contents with the row and section number.
        // The Basic cell style guarantees a label view is present in textLabel.
        cell.textLabel!.text = self.memes[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "memeDescriptionSegue", sender: memes[indexPath.row])
    }
    
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "memeDescriptionSegue" {
            /*if let indexPath = self.tableView.indexPathForSelectedRow {
                let meme = memes[indexPath.row]
                if let ViewControllerDestination = segue.destination as? MemeDescriptionViewController{
                    ViewControllerDestination.meme = meme
                }
            }*/
            
            if let vc = segue.destination as? MemeDescriptionViewController {
                vc.meme = sender as? Meme
            }
        }
    }
    
    
}
