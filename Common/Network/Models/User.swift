
import Foundation

struct User: Codable {
    let id: Int
    let uid, password: String
    let first_name, last_name, username: String
    let email, avatar, gender, phone_number: String
    let social_insurance_number, date_of_birth: String
    let employment: Employment
    let address: Address
    let credit_card: CreditCard
    let subscription: Subscription
}
