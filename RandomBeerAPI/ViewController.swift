import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    let url = "https://api.punkapi.com/v2/beers/random"

    func getRandomBeer(url: String) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
        
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            guard error == nil else { return }
            
            switch response.statusCode {
            
            case 200:
            print("성공")
            
                guard let beer: [RandomBeer] = try? JSONDecoder().decode([RandomBeer].self, from: data)
                else { return }
                let imageURL = URL(string: beer[0].image_url)!
                let imageData = try? Data(contentsOf: imageURL)
                DispatchQueue.main.async {
                self.idLabel.text = String(beer[0].id)
                self.nameLabel.text = beer[0].name
                self.taglineLabel.text = beer[0].tagline
                self.firstLabel.text = beer[0].first_brewed
                
                if let data = imageData {
                self.imageView.image = UIImage(data: data)
                    }
                }
    
            default:
                print("실패, \(error?.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    @IBAction func BeerButton(_ sender: UIButton) {
    getRandomBeer(url: url)
    }
}

