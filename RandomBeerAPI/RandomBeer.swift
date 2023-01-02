import Foundation

struct RandomBeer: Decodable {
    let id: Int
    let name: String
    let tagline: String
    let first_brewed: String
    let image_url: String
    let volume: Volume
    
    struct Volume: Decodable {
        let value: Int
        let unit: String
    }
}


