
import Foundation

public struct User: Codable {
    public let id: Int
    public let uid, password: String
    public let first_name, last_name, username: String
    public let email, avatar, gender, phone_number: String
    public let social_insurance_number, date_of_birth: String
    public let employment: Employment
    public let address: Address
    public let credit_card: CreditCard
    public let subscription: Subscription
}
