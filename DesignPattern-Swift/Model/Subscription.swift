
import Foundation

public struct Subscription: Codable {
    public let plan: String
    public let status: String
    public let payment_method: String
    public let term: String
}
