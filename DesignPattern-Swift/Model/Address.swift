
import Foundation

public struct Address: Codable {
    public let city: String
    public let street_name, street_address: String
    public let zip_code: String
    public let state: String
    public let country: String
    public let coordinates: Coordinates
}
