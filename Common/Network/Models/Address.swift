
import Foundation

struct Address: Codable {
    let city: String
    let street_name, street_address: String
    let zip_code: String
    let state: String
    let country: String
    let coordinates: Coordinates
}
